FROM klutchell/rar as rar

#ARG REPO=mcr.microsoft.com/dotnet/runtime
FROM mcr.microsoft.com/dotnet/runtime:7.0.8-alpine3.18-amd64
COPY --from=rar /usr/local/bin/rar /usr/local/bin/rar

COPY . /app
WORKDIR /app

ENV ASPNET_VERSION=7.0.8

ENV PASSWORD = "123";

RUN wget -O dotnet.tar.gz https://dotnetcli.azureedge.net/dotnet/Runtime/$DOTNET_VERSION/dotnet-runtime-$DOTNET_VERSION-linux-musl-x64.tar.gz

RUN mkdir -p /usr/share/dotnet
RUN tar -oxzf dotnet.tar.gz -C /usr/share/dotnet
RUN rm dotnet.tar.gz

RUN apk add gcompat

CMD ./AutoRar $PASSWORD