ARG THIS_ARCH_ALT=amd64
FROM multiarch/alpine:${THIS_ARCH_ALT}-edge

ARG THIS_ARCH_ALT=amd64
ARG THIS_ARCH_GO=amd64

LABEL Lan Tian "sms@codeideal.com"
ENV FRP_VER=0.25.3
RUN apk --no-cache add wget tar \
  && mkdir /frp \
  && wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${FRP_VER}/frp_${FRP_VER}_linux_${THIS_ARCH_GO}.tar.gz \
  && tar xf frp_${FRP_VER}_linux_${THIS_ARCH_GO}.tar.gz \
  && rm frp_${FRP_VER}_linux_${THIS_ARCH_GO}.tar.gz \
  && mv frp_${FRP_VER}_linux_${THIS_ARCH_GO}/frps /usr/bin/ \
  && mv frp_${FRP_VER}_linux_${THIS_ARCH_GO}/frps_full.ini /frp/ \
  && rm -rf frp_${FRP_VER}_linux_${THIS_ARCH_GO} \
  && chmod +x /usr/bin/frps \
  && apk del --purge wget tar
WORKDIR /frp
ENTRYPOINT ["/usr/bin/frps", "-c", "./frps_full.ini"]
