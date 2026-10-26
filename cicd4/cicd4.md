## Build & push image 
```yaml
- uses: docker/login-action@v3
  with:
    registry: ghcr.io
    username: ${{ github.repository_owner }}
    password: ${{ secrets.GITHUB_TOKEN }}
- uses: docker/build-push-action@v7
  with:
    context: .
    push: true
    tags: ${{ env.IMAGE }}:latest
permissions: packages: write wajib.

Tag mesti huruf kecil — ghcr.io/Kengkorok/... gagal: invalid tag: repository name must be lowercase. Fix: echo "IMAGE=ghcr.io/${GITHUB_REPOSITORY,,}" >> "$GITHUB_ENV".

Self-hosted runner (EC2)
Settings → Actions → Runners → New self-hosted runner → Linux/x64.
Di EC2: muat turun, ./config.sh --url ... --token ..., uji ./run.sh, kemudian jadikan service: sudo ./svc.sh install <user> && sudo ./svc.sh start.
Token daftar luput 1 jam.
Runner tak boleh jalan sebagai root.
User runner mesti dalam group docker, kalau tidak: permission denied while trying to connect to the docker API at unix:///var/run/docker.sock
Jangan jalan ./run.sh dalam sesi SSH sahaja — runner mati bila sesi tutup.
Auto-deploy
deploy:
  needs: build-push
  runs-on: self-hosted
  steps:
    - uses: actions/checkout@v7
    - run: docker compose up -d --pull always
compose.yaml guna imej, bukan build:

services:
  board:
    image: ghcr.io/<user>/ship-dashboard:latest
    ports: ["80:3000"]
--pull always paksa ambil imej terkini; tanpa itu Docker guna cache lama.

Untuk kelas kali ni, saya lost sekejap, ec2 saya tidak dapat connect dan error. Apa yang saya buat?
- Instance mesti ada public IP (Elastic IP) atau SSM; subnet saya MapPublicIpOnLaunch=false → tiada IP.
- Security group perlu port 80 (site) dan 22 (SSH/Instance Connect).
- Buka site guna http://<ip> — Chrome/Brave/any browser auto-naik ke https dan nampak macam mati.
pada akhirnya saya berjaya buka. 