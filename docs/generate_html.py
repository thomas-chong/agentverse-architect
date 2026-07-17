#!/usr/bin/env python3
"""
Generate docs/assigned-project-setup.html from docs/codelab-instructions.md.

The Markdown file is the single source of truth for the instruction content.
This script splits it into the 10 codelab sections, renders each to HTML, and
injects them into a Google-Codelabs-style reader shell with a working sidebar,
prev/next navigation, keyboard arrows, and hash routing.

Re-run after editing codelab-instructions.md:
    python3 docs/generate_html.py
"""
import re
import sys
import html as html_lib
from pathlib import Path
import markdown

HERE = Path(__file__).resolve().parent
SRC = HERE / "codelab-instructions.md"
OUT = HERE / "assigned-project-setup.html"

# Short sidebar labels (kept readable) per step number.
LABELS = {
    1: "Overture",
    2: "The Summoner's Concord",
    3: "Drawing the Summoning Circle 🛠️",
    4: "Forging the Elemental Fonts",
    5: "Summoning the Familiars",
    6: "Command Locus (A2A)",
    7: "Laws of Magic",
    8: "Agent State & Memory",
    9: "The Boss Fight",
    10: "Cleanup",
}
PATCHED_STEP = 3  # the only section we modified


def split_sections(text: str):
    """Yield (step_number, title, body_markdown) for each '## N. Title' section."""
    header_re = re.compile(r"^##\s+(\d+)\.\s+(.+)$", re.MULTILINE)
    matches = list(header_re.finditer(text))
    for i, m in enumerate(matches):
        n = int(m.group(1))
        title = m.group(2).strip()
        start = m.end()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        body = text[start:end].strip()
        # Drop standalone horizontal rules that separate sections.
        body = re.sub(r"^\s*---\s*$", "", body, flags=re.MULTILINE).strip()
        yield n, title, body


def render(body_md: str) -> str:
    return markdown.markdown(
        body_md,
        extensions=["fenced_code", "tables", "attr_list", "sane_lists", "toc"],
    )


def build_sidebar(steps):
    items = []
    for n in steps:
        label = LABELS.get(n, f"Step {n}")
        items.append(
            f'      <div class="step" data-step="{n}">'
            f'<div class="num">{n}</div><div class="label">{html_lib.escape(label)}</div></div>'
        )
    return "\n".join(items)


def build_panels(sections):
    panels = []
    for n, title, body in sections:
        tag = (
            f"Step {n} · 🛠️ Workshop Patch (only modified step)"
            if n == PATCHED_STEP
            else f"Step {n} · Official codelab"
        )
        body_html = render(body)
        panels.append(
            f'      <section class="panel" data-step="{n}">\n'
            f'        <div class="section-tag">{html_lib.escape(tag)}</div>\n'
            f'        <h1>{html_lib.escape(title)}</h1>\n'
            f'        <div class="md">\n{indent(body_html, 10)}\n        </div>\n'
            f"      </section>"
        )
    return "\n\n".join(panels)


def indent(text: str, spaces: int) -> str:
    pad = " " * spaces
    return "\n".join((pad + line if line.strip() else line) for line in text.splitlines())


TEMPLATE = """<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Agentverse Architect — Patched Codelab Reader</title>
  <meta name="description" content="Mirrored Agentverse Architect codelab with a patched init.sh / billing flow for assigned (Qwiklabs) projects.">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&family=Google+Sans+Text:wght@400;500;700&family=Google+Sans+Code:wght@400;500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github-dark.min.css">
  <style>
    :root {
      --blue:#1a73e8; --blue-dark:#1557b0; --blue-soft:#e8f0fe;
      --gray-bg:#f8f9fa; --gray-line:#e0e0e0; --gray-text:#5f6368;
      --text:#202124; --green:#1e8e3e; --red:#d93025; --amber:#f9ab00;
      --font:'Google Sans Text','Google Sans',Roboto,Arial,sans-serif;
      --display:'Google Sans',Roboto,Arial,sans-serif;
      --mono:'Google Sans Code','JetBrains Mono',monospace;
    }
    *{box-sizing:border-box;}
    html,body{margin:0;padding:0;height:100%;}
    body{font-family:var(--font);color:var(--text);background:var(--gray-bg);font-size:15px;line-height:1.6;}

    #topbar{display:flex;align-items:center;justify-content:space-between;height:64px;padding:0 24px;background:#fff;border-bottom:1px solid var(--gray-line);position:sticky;top:0;z-index:100;}
    .brand{display:flex;align-items:center;gap:12px;}
    .gcloud-logo{width:28px;height:28px;background:linear-gradient(135deg,#4285f4,#1a73e8);border-radius:6px;position:relative;}
    .gcloud-logo::after{content:"";position:absolute;inset:6px;background:#fff;clip-path:polygon(50% 0,100% 50%,50% 100%,0 50%);}
    .brand .title{font-family:var(--display);font-weight:500;font-size:18px;}
    .brand .title b{font-weight:700;}
    .topbar-right{display:flex;align-items:center;gap:20px;color:var(--gray-text);}
    .lang{display:flex;align-items:center;gap:6px;font-size:14px;cursor:pointer;}
    .avatar{width:32px;height:32px;border-radius:50%;background:var(--blue);color:#fff;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:700;font-family:var(--display);}

    #app{display:flex;min-height:calc(100vh - 64px);}
    #sidebar{width:300px;background:#fff;border-right:1px solid var(--gray-line);padding:20px 0;flex-shrink:0;align-self:flex-start;position:sticky;top:64px;max-height:calc(100vh - 64px);overflow-y:auto;}
    .step{display:flex;align-items:center;gap:12px;padding:10px 20px;cursor:pointer;color:var(--gray-text);border-left:4px solid transparent;transition:background .12s;}
    .step:hover{background:#f1f3f4;}
    .step .num{width:26px;height:26px;border-radius:50%;background:#e8eaed;color:var(--gray-text);display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:700;flex-shrink:0;font-family:var(--display);}
    .step .label{font-size:14px;}
    .step.active{background:var(--blue-soft);color:var(--blue-dark);border-left-color:var(--blue);}
    .step.active .num{background:var(--blue);color:#fff;}
    .step.done .num{background:var(--green);color:#fff;}

    #main{flex:1;max-width:860px;margin:0 auto;padding:40px 56px 120px;background:#fff;}
    .panel{display:none;}
    .panel.active{display:block;animation:fade .2s ease;}
    @keyframes fade{from{opacity:0;transform:translateY(4px);}to{opacity:1;transform:none;}}
    .section-tag{font-family:var(--display);font-size:13px;font-weight:700;color:var(--blue);text-transform:uppercase;letter-spacing:.6px;margin-bottom:6px;}
    h1{font-family:var(--display);font-size:32px;font-weight:700;margin:0 0 8px;line-height:1.25;}

    /* Rendered Markdown body */
    .md > *:first-child{margin-top:0;}
    .md p{margin:0 0 16px;}
    .md .lead,.md p.lead{font-size:16px;color:#3c4043;}
    .md strong{font-weight:700;}
    .md a{color:var(--blue);text-decoration:none;}
    .md a:hover{text-decoration:underline;}
    .md h2{font-family:var(--display);font-size:24px;font-weight:700;margin:32px 0 12px;}
    .md h3{font-family:var(--display);font-size:19px;font-weight:700;margin:26px 0 10px;}
    .md h4{font-family:var(--display);font-size:16px;font-weight:700;margin:20px 0 8px;color:var(--gray-text);text-transform:uppercase;letter-spacing:.4px;}
    .md ul,.md ol{margin:0 0 16px;padding-left:24px;}
    .md li{margin:6px 0;}
    .md img{max-width:100%;height:auto;border-radius:10px;border:1px solid var(--gray-line);display:block;margin:16px 0;background:var(--gray-bg);}
    .md blockquote{margin:18px 0;padding:16px 20px;border-left:4px solid var(--amber);background:#fef7e0;border-radius:0 10px 10px 0;color:#5f4915;}
    .md blockquote p{margin:6px 0;}
    .md blockquote h3{margin-top:0;color:#b06000;}
    .md code{font-family:var(--mono);font-size:13px;background:#f1f3f4;padding:2px 6px;border-radius:4px;}
    .md pre{background:#0d1117;border:1px solid var(--gray-line);border-radius:10px;padding:16px 18px;overflow-x:auto;margin:12px 0 20px;position:relative;}
    .md pre code{background:transparent;padding:0;font-size:13px;line-height:1.6;color:#e8eaed;}
    .md pre:hover > .copy-btn{opacity:1;}
    .copy-btn{position:absolute;top:8px;right:8px;font-family:var(--display);font-size:12px;font-weight:700;padding:4px 10px;border-radius:6px;border:1px solid rgba(255,255,255,.25);background:rgba(255,255,255,.08);color:#e8eaed;cursor:pointer;opacity:0;transition:opacity .12s,background .12s;backdrop-filter:blur(4px);}
    .copy-btn:hover{background:rgba(255,255,255,.18);}
    .copy-btn.copied{background:var(--green);border-color:var(--green);color:#fff;opacity:1;}
    .md hr{border:none;border-top:1px solid var(--gray-line);margin:24px 0;}
    .md table{border-collapse:collapse;width:100%;margin:16px 0;font-size:14px;}
    .md th,.md td{border:1px solid var(--gray-line);padding:8px 10px;text-align:left;}
    .md th{background:var(--gray-bg);font-family:var(--display);font-weight:700;}

    #nav{display:flex;justify-content:space-between;align-items:center;margin-top:48px;padding-top:24px;border-top:1px solid var(--gray-line);}
    .btn{font-family:var(--display);font-size:14px;font-weight:700;padding:10px 28px;border-radius:6px;border:1px solid var(--gray-line);cursor:pointer;background:#fff;color:var(--gray-text);transition:all .12s;text-decoration:none;display:inline-flex;align-items:center;gap:8px;}
    .btn:hover:not([disabled]){background:#f1f3f4;}
    .btn.primary{background:var(--blue);color:#fff;border-color:var(--blue);}
    .btn.primary:hover:not([disabled]){background:var(--blue-dark);border-color:var(--blue-dark);}
    .btn[disabled]{opacity:.4;cursor:not-allowed;}
    .progress{font-family:var(--display);font-size:13px;color:var(--gray-text);font-weight:500;}

    #footer{padding:16px 56px;color:var(--gray-text);font-size:13px;border-top:1px solid var(--gray-line);background:#fff;}
    .report{display:flex;align-items:center;gap:6px;}
    .report a{color:inherit;}

    @media (max-width:840px){#sidebar{display:none;}#main{padding:32px 24px 80px;}}
  </style>
</head>
<body>
  <div id="topbar">
    <div class="brand">
      <div class="gcloud-logo"></div>
      <div class="title">Google Cloud &nbsp;·&nbsp; <b>Agentverse Architect (Patched)</b></div>
    </div>
    <div class="topbar-right">
      <div class="lang">🌐 English</div>
      <div class="avatar">TC</div>
    </div>
  </div>

  <div id="app">
    <div id="sidebar">
__SIDEBAR__
    </div>

    <div id="main">
__PANELS__

      <div id="nav">
        <button class="btn" id="prevBtn" type="button">← Back</button>
        <span class="progress" id="progress">3 / 10</span>
        <button class="btn primary" id="nextBtn" type="button">Next →</button>
      </div>
    </div>
  </div>

  <div id="footer">
    <div class="report">⚙️ Report a mistake · 📄 <a href="codelab-instructions.md">Full mirrored codelab (Markdown)</a> · 🔗 <a href="https://codelabs.developers.google.com/agentverse-architect/instructions">Official codelab</a> · 🛠️ <a href="../init.sh">init.sh</a> / <a href="../billing-enablement.py">billing-enablement.py</a></div>
  </div>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"></script>
  <script>
    (function () {
      const steps = Array.from(document.querySelectorAll('.step'));
      const panels = Array.from(document.querySelectorAll('.panel'));
      const prevBtn = document.getElementById('prevBtn');
      const nextBtn = document.getElementById('nextBtn');
      const progress = document.getElementById('progress');
      const total = steps.length;
      const DEFAULT = {DEFAULT};
      const visited = new Set();

      function current() {
        const h = parseInt((location.hash || '').replace('#', ''), 10);
        return (h >= 1 && h <= total) ? h : DEFAULT;
      }

      function showStep(n, push) {
        if (n < 1 || n > total) return;
        visited.add(n);
        steps.forEach(s => {
          const k = Number(s.dataset.step);
          s.classList.toggle('active', k === n);
          s.classList.toggle('done', visited.has(k) && k !== n);
        });
        panels.forEach(p => p.classList.toggle('active', Number(p.dataset.step) === n));
        prevBtn.disabled = n === 1;
        nextBtn.disabled = n === total;
        progress.textContent = n + ' / ' + total;
        if (push) history.replaceState(null, '', '#' + n);
        window.scrollTo({ top: 0, behavior: 'smooth' });
      }

      steps.forEach(s => s.addEventListener('click', () => showStep(Number(s.dataset.step), true)));
      prevBtn.addEventListener('click', () => showStep(current() - 1, true));
      nextBtn.addEventListener('click', () => showStep(current() + 1, true));

      document.addEventListener('keydown', e => {
        if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') return;
        if (e.key === 'ArrowLeft') { e.preventDefault(); showStep(current() - 1, true); }
        if (e.key === 'ArrowRight') { e.preventDefault(); showStep(current() + 1, true); }
      });

      window.addEventListener('hashchange', () => showStep(current(), false));

      showStep(current(), false);
      if (window.hljs) hljs.highlightAll();

      // Copy button on every code snippet
      function addCopyButtons() {
        document.querySelectorAll('.md pre').forEach(pre => {
          if (pre.querySelector('.copy-btn')) return;
          const code = pre.querySelector('code');
          if (!code) return;
          const btn = document.createElement('button');
          btn.className = 'copy-btn';
          btn.type = 'button';
          btn.textContent = 'Copy';
          btn.setAttribute('aria-label', 'Copy code to clipboard');
          btn.addEventListener('click', async () => {
            const text = code.innerText;
            try {
              await navigator.clipboard.writeText(text);
              btn.textContent = 'Copied ✓';
              btn.classList.add('copied');
              setTimeout(() => { btn.textContent = 'Copy'; btn.classList.remove('copied'); }, 1500);
            } catch (e) {
              btn.textContent = 'Press ⌘C';
              setTimeout(() => { btn.textContent = 'Copy'; }, 1500);
            }
          });
          pre.appendChild(btn);
        });
      }
      addCopyButtons();
    })();
  </script>
</body>
</html>
"""


def main():
    text = SRC.read_text()
    sections = list(split_sections(text))
    if not sections:
        sys.exit("No '## N. Title' sections found in " + str(SRC))

    steps = [n for n, _, _ in sections]
    sidebar = build_sidebar(steps)
    panels = build_panels(sections)

    page = (
        TEMPLATE
        .replace("__SIDEBAR__", sidebar)
        .replace("__PANELS__", panels)
        .replace("{DEFAULT}", str(PATCHED_STEP))
    )
    OUT.write_text(page)
    print(f"Wrote {OUT}  ({len(sections)} sections, {len(page)} bytes)")


if __name__ == "__main__":
    main()
