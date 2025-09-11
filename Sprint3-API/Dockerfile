# Base runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

# Build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["Sprint3-API.csproj", "."]
RUN dotnet restore "./Sprint3-API.csproj"
COPY . .
RUN dotnet build "Sprint3-API.csproj" -c Release -o /app/build

# Publish
FROM build AS publish
RUN dotnet publish "Sprint3-API.csproj" -c Release -o /app/publish

# Final
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Sprint3-API.dll"]
