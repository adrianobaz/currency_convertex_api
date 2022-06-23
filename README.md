# CurrencyConvertexApi

Description

Service responsible for converting monetary values between various available currencies. 
The exchange rates are consumed from the service Exchange Rates. See the referenrence 
[here](https://exchangeratesapi.io/documentation/) 

## How it works:
### **1. Docker. First, you need to install docker**
* Download Docker [Here](https://docs.docker.com/desktop/);
* Then open powershell and check:
```bash
docker info
```
or check docker version
```bash
docker -v
```
or docker compose version
```bash
docker-compose -v
```
### **2. Spring boot app**
* Clone the repository:
```bash
git clone https://github.com/adrianobaz/rest-currency-convert.git
```
* Build the maven project:
```bash
./mvnw clean package -DskipTests
```
* Running the containers:

This command will build the docker containers and start them.
```bash
docker-compose up
```
or

This is a similar command as above, except it will run all the processes in the background.
```bash
docker-compose -f docker-compose.yml up
```

Appendix A.

All commands should be run from project root (where docker-compose.yml locates)

* If you have to want to see running containers. Checklist docker containers
```bash
docker container list -a
```
or
```bash
docker-compose ps
```

---

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# How to consume API




Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix