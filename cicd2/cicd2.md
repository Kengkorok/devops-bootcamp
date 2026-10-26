## Gate (pre-flight)
- `launchpad/scripts/preflight.mjs` semak `ship.config.json`:
  `shipName` 1–24 huruf atau abjad, `color` hex `#rgb` atau nama warna, eg : pink, red, black, etc
  `shipModel` : fighter/interceptor/hauler/scout, `emblem` : comet/bolt/star/ring/delta/phoenix.
- Lulus → `✓ pre-flight OK`. Gagal → `ABORT` + exit kod 1 → run merah.

## needs
```yaml
deploy:
  needs: test
Deploy tak jalan kalau test gagal. Job yang di-needs skip → job dependent pun skip.

Branch protection
Settings → Branches → Add rule (main):

Require a pull request before merging
Require status checks to pass (test)

## Pengalaman sebenar
Saya pernah merge PR dengan marker konflik <<<<<<< HEAD masih dalam YAML → workflow jadi invalid, run 0 saat, main merah.
Sebab tu branch + PR + gate penting: kesilapan tertangkap sebelum masuk main.
ship.config.json saya pernah letak "color": "22d3ee" (tiada #) → pre-flight ABORT: color must be a hex string like #22d3ee or a colour name