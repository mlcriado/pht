FROM ubuntu:16.04

# Install LXDE, Twisted, SWIG and Qt
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server x11-apps lxde-core lxterminal curl gnupg g++ libcrypto++-dev swig python-dev python-twisted libqtcore4 libqt4-dev python-qt4 pyqt4-dev-tools python-psutil xdg-utils pkg-config build-essential autoconf libtool rsync

# Download bitcoin - Comentado
RUN mkdir /bitcoin
WORKDIR /bitcoin
ENV BITCOIN_VERSION 0.16.3
RUN curl -SLO "https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz" \
  && curl -SLO "https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS.asc"

# Verify and install download - Comentado
COPY laanwj-releases.asc /bitcoin
RUN gpg --import laanwj-releases.asc \
 && tar -xzf "bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz" -C /usr --strip-components=1 \
 && rm "bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz" SHA256SUMS.asc

RUN ln -s /bitcoin /root/.bitcoin

# Download armory
RUN mkdir /armory
WORKDIR /armory
ENV ARMORY_VERSION 0.96.5
RUN curl -SLO "https://github.com/goatpig/BitcoinArmory/releases/download/v${ARMORY_VERSION}/armory_${ARMORY_VERSION}_source.tar.xz"
RUN curl -SLO "https://github.com/goatpig/BitcoinArmory/releases/download/v${ARMORY_VERSION}/sha256sum.txt.asc"

# Verify and unpack download
COPY goatpig-signing-key.asc /armory
RUN gpg --import goatpig-signing-key.asc \
 && tar -xf "armory_${ARMORY_VERSION}_source.tar.xz" \
 && rm "armory_${ARMORY_VERSION}_source.tar.xz" sha256sum.txt.asc

# build and install
WORKDIR /armory/Armory3
RUN ./autogen.sh && ./configure && make && make install

WORKDIR /armory
RUN rm -rf SRC_DIR
RUN ln -s /armory /root/.armory
RUN mkdir /root/.ssh \
 && chmod 700 /root/.ssh \
 && mkdir /var/run/sshd \
 && perl -p -i -e "s/\#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config

# Copiar la clave pública al contenedor y modificar permisos
COPY pht.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

# Configurar SSH para aceptar autenticación por clave pública
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

# Configurar SSH para X11 forwarding
RUN echo "X11UseLocalhost no" >> /etc/ssh/sshd_config
 
# Expose SSH port for X11 forwarding
ENV DISPLAY :0
EXPOSE 22

# Comando para iniciar SSHD
CMD ["/usr/sbin/sshd", "-D"]