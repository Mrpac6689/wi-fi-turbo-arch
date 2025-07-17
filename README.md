# WiFi Turbo Boost for Arch Linux
by MrPaC6689

This script (`wifi-turbo.sh`) optimizes Wi-Fi connections on Arch Linux, especially for Intel 8265 / 8275 chipsets (or similar dual-band 5GHz cards).  
It fixes common issues such as low speed, incorrect regulatory domain, power-saving mode bottlenecks, and missing firmware.

## 🔧 What the script does

- Installs essential dependencies:
  - `iw`
  - `wireless-regdb`
  - `speedtest-cli`

- Fixes the regulatory domain (`regdom`) by persistently applying `BR`:
  - Creates a `tmpfiles.d` entry to run `iw reg set BR` at boot.
  - Creates the `/etc/iw.regset` helper script used by that rule.

- Edits `mkinitcpio.conf` to:
  - Add `iwlwifi` and `cfg80211` to `MODULES`.
  - Include `regulatory.db` in `FILES`.

- Rebuilds `initramfs` to apply changes from boot.

- Disables Wi-Fi power-saving via NetworkManager:
  - Sets `wifi.powersave = 2`.

- Restarts NetworkManager and applies `iw reg set BR` manually.

- Runs a real-world connection speed test using `speedtest.net`.

## 📥 Installation

```bash
git clone https://github.com/yourusername/wifi-turbo-arch.git
cd wifi-turbo-arch
chmod +x wifi-turbo.sh
./wifi-turbo.sh
```

> 💡 Run as root or with `sudo`.

## 🔁 Post-install reboot recommended

Reboot your system to ensure:

- Updated initramfs is loaded
- The `BR` regdom is applied early in the boot
- Power saving remains disabled

## 🧪 Test your connection

```bash
speedtest
```

Or open [https://fast.com](https://fast.com) in your browser.

## ✅ Requirements

- Arch Linux (or derivative)
- Compatible Wi-Fi chipset (preferably Intel AC)
- Kernel with `iwlwifi` module support

## 📄 License

MIT — use freely and feel free to contribute improvements.
