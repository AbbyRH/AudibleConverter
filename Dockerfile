FROM node

WORKDIR /app
VOLUME /app/media
RUN npm i audible-converter
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y ffmpeg git && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/nu774/m4acut.git
RUN git clone https://github.com/l-smash/l-smash.git
WORKDIR /app/l-smash
RUN ./configure && make && make install
WORKDIR /app/m4acut
RUN autoreconf -i &&./configure && make && make install
WORKDIR /app
COPY convert.sh /app/convert.sh
RUN chmod u+x /app/convert.sh
CMD /app/convert.sh
