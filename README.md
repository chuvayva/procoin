# Procoin

Procoin is a client web site for [Procoin Token](https://github.com/chuvayva/procoin-token).

The system works with blockchain via Ruby Ethereum Library [ethereum.rb](https://github.com/EthWorks/ethereum.rb) which internally uses [JSON RPC API](https://github.com/ethereum/wiki/wiki/JSON-RPC).

## Before you start
You should deploy Token to a blockchain. See [Deployment to Ropsten](https://github.com/chuvayva/procoin-token#deployment-to-ropsten).

## Getting Started
Make sure you have Ruby 2.3.1, PostgreSQL, Redis and Yarn installed.

Install gems:
```
bundle install
```

Setup DB:

```
bundle exec rake db:reset
```
It will create _procoin_ DB in postgres.

Install js packages:

```
yarn install
```

## Run Server

The system consist of several processes listed in the _Procfile_. Run it using [Foreman](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html), [Hivemind or Overmind](https://evilmartians.com/chronicles/introducing-overmind-and-hivemind)
```
hivemind
```

## Tests

Make sure you have setup test database. You can do it by:
```
RAILS_ENV=test bundle exec rake db:reset
```

Then run rspec tests:
```
rspec
```


## Configuration

We use [dotenv-rails](https://github.com/bkeepers/dotenv) for app configuration. Use `.env.development` for customization.

To cutomize JSON RPC server set `ETHEREUM_RPC_URL` environment variable. For instance you can use [Infura](https://infura.io):
```
ETHEREUM_RPC_URL=https://ropsten.infura.io/<your infura key>
```

You had better sign up and have you own token, but `https://ropsten.infura.io` also works. Check [Getting started with Infura](https://blog.infura.io/getting-started-with-infura-28e41844cc89).


You need to deploy Procoin token to a blockchain and set it's address:
```
ETHEREUM_TOKEN_ADDRESS=<procoin address>
```

You should have an account with ether to make transactions. Set it via:
```
ETHEREUM_ADMIN_ACCOUNT=<account address>
ETHEREUM_ADMIN_PRIVATE_KEY=<account private key>
```

You can existed or generate them in console:
```
bundle exec rails console
key = Eth::Key.new
key.address
key.private_hex
```



