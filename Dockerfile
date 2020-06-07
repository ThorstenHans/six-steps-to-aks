FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS builder
WORKDIR /src
COPY ./HelloAKS.csproj .
RUN dotnet restore HelloAKS.csproj
COPY . .
RUN dotnet build HelloAKS.csproj -c Debug -o /src/out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim
WORKDIR /app
COPY --from=builder /src/out .

EXPOSE 5000
ENTRYPOINT ["dotnet", "HelloAKS.dll"]
