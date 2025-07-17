#!/bin/bash
set -e

echo ">> Instalando dependências..."
sudo pacman -S --noconfirm iw wireless-regdb speedtest-cli

echo ">> Criando regra tmpfiles para regdom BR..."
echo 'w /etc/iw.regset - - - - /usr/bin/iw reg set BR' | sudo tee /etc/tmpfiles.d/iw.regdom.conf > /dev/null

echo ">> Criando script iw.regset..."
echo '#!/bin/bash
/usr/bin/iw reg set BR' | sudo tee /etc/iw.regset > /dev/null
sudo chmod +x /etc/iw.regset

echo ">> Garantindo configuração no mkinitcpio.conf..."
sudo sed -i '/^MODULES=/ s/)/ iwlwifi cfg80211)/' /etc/mkinitcpio.conf
sudo sed -i '/^FILES=/ s/)/ \/lib\/firmware\/regulatory.db \/lib\/firmware\/regulatory.db.p7s)/' /etc/mkinitcpio.conf

echo ">> Regerando initramfs..."
sudo mkinitcpio -P

echo ">> Desativando power save via NetworkManager..."
sudo mkdir -p /etc/NetworkManager/conf.d
echo -e "[connection]\nwifi.powersave = 2" | sudo tee /etc/NetworkManager/conf.d/wifi-powersave.conf > /dev/null
sudo systemctl restart NetworkManager

echo ">> Aplicando regdom temporariamente..."
sudo iw reg set BR

echo ">> Verificação final do regdom:"
iw reg get

echo "---------------------------------------------------"
echo ">> Testando velocidade da conexão (speedtest.net)..."
echo "---------------------------------------------------"
speedtest
