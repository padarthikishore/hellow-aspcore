FROM mcr.microsoft.com/dotnet/aspnet:3.1-focal AS base
WORKDIR /app
EXPOSE 80

ENV ASPNETCORE_URLS=http://+:80

FROM mcr.microsoft.com/dotnet/sdk:3.1-focal AS build
WORKDIR /src
COPY ["HellowAspNetCore.csproj", "./"]
RUN dotnet restore "HellowAspNetCore.csproj"
COPY . .
RUN dotnet build "HellowAspNetCore.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "HellowAspNetCore.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HellowAspNetCore.dll"]
