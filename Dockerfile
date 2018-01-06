FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig xminer
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        build-base && \
      cd / && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      sed -i -e 's/constexpr const int kDonateLevel = 5;/constexpr const int kDonateLevel = 0;/g' src/donate.h && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release -DWITH_HTTPD=OFF . && \
      make && \
      apk del \
        build-base \
        cmake \
        git
USER xminer
WORKDIR    /xmrig
ENTRYPOINT   ["./xmrig", "--algo=cryptonight", "--url=stratum+tcp://pool.etn.spacepools.org:3333", "--user=etnkFJW3Fga5RrH6xQB7SFWsQW63tzQMNZG7pUTUwXAFGiqqK3BMHfRfbK7p1868wcJVvVLc8e1qAXEtTFc7jw4Z9kcfpKPLSq.5000@nodes", "--pass=x", "--max-cpu-usage=100"]
