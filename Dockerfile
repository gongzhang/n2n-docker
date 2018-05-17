FROM alpine:3.7 AS build

RUN apk add --no-cache --update git make gcc linux-headers musl-dev openssl-dev

WORKDIR /n2n
RUN git clone https://github.com/ntop/n2n.git /n2n
RUN make && make install


FROM alpine:3.7

RUN apk add --no-cache --update openssl

COPY --from=build /usr/sbin/edge /usr/sbin/edge
COPY --from=build /usr/sbin/supernode /usr/sbin/supernode
