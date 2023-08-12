# 2022 December
FROM debian:stable@sha256:880aa5f5ab441ee739268e9553ee01e151ccdc52aa1cd545303cfd3d436c74db

ENV DEBIAN_FRONTEND noninteractive
ENV PATH="${PATH}:/opt/cprocsp/bin/amd64/"

# Downloaded from https://www.cryptopro.ru/fns_experiment
ADD linux-amd64_deb.tgz /cryptopro

# Downloaded from https://www.rutoken.ru/support/download/pkcs/#linux
COPY librtpkcs11ecp_2.8.1.0-1_amd64.deb /cryptopro

# Downloaded from https://restapi.moedelo.org/eds/crypto/plugin/api/v1/installer/download?os=linux&version=latest
COPY moedelo-plugin_*_amd64.deb /cryptopro

# Downloaded from install.kontur.ru
COPY diag.plugin_amd64.001648.deb /cryptopro

# Downloaded from https://ds-plugin.gosuslugi.ru/plugin/upload/Index.spr
COPY IFCPlugin-x86_64.deb /cryptopro

# Downloaded from https://www.rutoken.ru/support/download/get/rtPlugin-deb-x64.html
COPY libnpRutokenPlugin_*_amd64.deb /cryptopro

RUN apt-get update && \
    apt-get install -y whiptail libccid libpcsclite1 pcscd pcsc-tools opensc \
    libgtk2.0-0 libcanberra-gtk-module libcanberra-gtk3-0 libsm6 firefox-esr && \
    cd /cryptopro/linux-amd64_deb && \
    dpkg -i /cryptopro/librtpkcs11ecp_*_amd64.deb && \
    ./install.sh && \
    dpkg -i /cryptopro/moedelo-plugin_*_amd64.deb && \
    dpkg -i /cryptopro/diag.plugin_amd64.001648.deb && \
    dpkg -i /cryptopro/IFCPlugin-x86_64.deb && \
    dpkg -i /cryptopro/libnpRutokenPlugin_*_amd64.deb && \
    dpkg -i /cryptopro/cprocsp-cptools-gtk-64_5.0.12900-7_amd64.deb && \
    dpkg -i /cryptopro/cprocsp-rdr-gui-gtk-64_5.0.12900-7_amd64.deb && \
    dpkg -i /cryptopro/lsb-cprocsp-import-ca-certs

# Downloaded from https://www.cryptopro.ru/sites/default/files/products/cades/extensions/firefox_cryptopro_extension_latest.xpi
COPY firefox_cryptopro_extension_latest.xpi /usr/lib/firefox-esr/distribution/extensions/ru.cryptopro.nmcades@cryptopro.ru.xpi

# Downloaded from install.kontur.ru (firefox addon)
COPY kontur.extension@kontur.ru.xpi /usr/lib/firefox-esr/distribution/extensions/kontur.toolbox@gmail.com.xpi

# Downloaded from https://ds-plugin.gosuslugi.ru/plugin/upload/Index.spr
COPY addon-1.2.8-fx.xpi /usr/lib/firefox-esr/distribution/extensions/pbafkdcnd@ngodfeigfdgiodgnmbgcfha.ru.xpi

# Downloaded from https://addons.mozilla.org/ru/firefox/addon/adapter-rutoken-plugin/
COPY adapter_rutoken_plugin-1.0.5.0.xpi /usr/lib/firefox-esr/distribution/extensions/rutokenplugin@rutoken.ru.xpi

CMD ["bash"]
