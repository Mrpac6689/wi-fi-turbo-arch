# WiFi Turbo Boost para Arch Linux
## por MrPaC6689

Este script (`wifi-turbo.sh`) otimiza conexões Wi-Fi no Arch Linux, especialmente para placas **Intel 8265 / 8275** ou similares com suporte a 5GHz, corrigindo problemas comuns como baixa velocidade, domínio regulatório incorreto, modo de economia de energia e falta de firmware.

## 🔧 O que o script faz

1. Instala dependências essenciais:
   - `iw`
   - `wireless-regdb`
   - `speedtest-cli`

2. Corrige o domínio regulatório (`regdom`) com aplicação persistente de `BR`:
   - Cria entrada no `tmpfiles.d` que executa `iw reg set BR` no boot.
   - Cria script `/etc/iw.regset` para uso pelo `tmpfiles`.

3. Corrige configuração do `mkinitcpio.conf`:
   - Adiciona `iwlwifi` e `cfg80211` em `MODULES`.
   - Adiciona `regulatory.db` no `FILES`.

4. Recria `initramfs` para aplicar as mudanças no boot.

5. Desativa o modo de economia de energia da placa Wi-Fi via NetworkManager:
   - Define `wifi.powersave = 2`.

6. Reinicia o `NetworkManager` e aplica `iw reg set BR`.

## 📥 Instalação

```bash
git clone https://github.com/seuusuario/wifi-turbo-arch.git
cd wifi-turbo-arch
chmod +x wifi-turbo.sh
./wifi-turbo.sh
