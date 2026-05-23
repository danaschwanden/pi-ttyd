FROM node:26-bookworm-slim AS base

ENV NODE_ENV=production
ENV DEBIAN_FRONTEND=noninteractive
ENV NPM_CONFIG_LOGLEVEL=warn
ENV HOME=/home/node

# -----------------------------------------------------------------------------
# Install dependencies
# -----------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    tini build-essential cmake git libjson-c-dev libwebsockets-dev \
    curl wget ca-certificates procps python3 python3-dev && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p -m 755 /etc/apt/keyrings \
    && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# Build ttyd
# -----------------------------------------------------------------------------
RUN git clone https://github.com/tsl0922/ttyd.git && \
    cd ttyd && mkdir build && cd build && \
    cmake .. && \
    make && make install

# -----------------------------------------------------------------------------
# System Hardening: Purge Privilege Escalation Vectors
# -----------------------------------------------------------------------------
RUN rm -f /bin/su /usr/bin/su /bin/mount /usr/bin/mount /bin/umount /usr/bin/umount \
    /usr/bin/passwd /usr/bin/chsh /usr/bin/chfn /usr/bin/chage /usr/bin/gpasswd \
    /usr/bin/newgrp /bin/login /usr/bin/login /usr/bin/nsenter /usr/bin/unshare \
    /usr/bin/setpriv /bin/setpriv \
    && find / -xdev \( -perm -4000 -o -perm -2000 \) -type f -exec chmod a-s {} + || true

FROM base AS release

# -----------------------------------------------------------------------------
# Install pi
# -----------------------------------------------------------------------------
RUN npm install -g @earendil-works/pi-coding-agent

RUN mkdir -p /home/node/.pi/agent \
    /workspace \
    /home/node/.config \
    /home/node/.npm && \
    chown -R node:node /home/node/.pi \
    /workspace \
    /home/node/.config \
    /home/node/.npm

# -----------------------------------------------------------------------------
# Install bun
# -----------------------------------------------------------------------------
RUN npm install -g bun

EXPOSE 7681
WORKDIR /workspace
USER node

ENTRYPOINT ["/usr/bin/tini", "--"]
#CMD ["ttyd", "-W", "bash"]
CMD ["ttyd", "-W", "pi"]
