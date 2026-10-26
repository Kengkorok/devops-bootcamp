# CI/CD 3 — Secret vs Variable & Lapor ke Board

## Bezanya
| | Variable (`vars`) | Secret (`secrets`) |
|---|---|---|
| Nampak dalam log | ya | tidak (ditopeng `***`) |
| Guna untuk | alamat, nama, config awam | token, password, API key |
| Set di | Settings → Secrets and variables → Actions → Variables | ... → Secrets |

Saya guna: `vars.BOARD_URL` (awam) + `secrets.SHIPIT_TOKEN` (rahsia).

## Step lapor
```yaml
- run: bash scripts/report.sh
  env:
    BOARD_URL: ${{ vars.BOARD_URL }}
    SHIPIT_TOKEN: ${{ secrets.SHIPIT_TOKEN }}

Pisahkan CI dan CD ikut PR
on:
  pull_request:
    types: [opened, synchronize, reopened, closed]
test:
  if: github.event.pull_request.merged == false
deploy:
  needs: test
  if: always() && github.event.pull_request.merged == true