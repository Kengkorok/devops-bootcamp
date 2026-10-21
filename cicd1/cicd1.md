# CI/CD 1 — Workflow, Job & Laman Pages

## Fail
`.github/workflows/deploy.yaml` — satu workflow, dua job (`test`, `deploy`).

## Konsep
- `on:` — pencetus. `push` = setiap push; boleh tambah `workflow_dispatch` untuk butang run manual.
- Job = satu unit kerja atas runner. Step = arahan dalam job.
- Runner `ubuntu-latest` = mesin GitHub (sementara, bersih setiap run).
- `defaults.run.working-directory: launchpad` — semua `run:` jalan dalam folder tu.

## Step penting
1. `actions/checkout` — ambil kod repo ke runner.
2. `actions/setup-node` — pasang Node.
3. `npm clean-install` + `npm run build` — bina site ke `launchpad/dist`.
4. `actions/upload-pages-artifact` — bungkus `dist` jadi artifact.
5. `actions/deploy-pages` — terbit ke GitHub Pages.

## Pages
Settings → Pages → Source: **GitHub Actions** (bukan branch).
URL: `https://<user>.github.io/<repo>/`

