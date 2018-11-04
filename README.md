# Asker

We wanted a private AskReddit. We now have this bot which publishes the top
AskReddit posts on a Slack channel for us to reply to.

## Installation

1. `git clone https://github.com/justmendes/asker`
2. `bin/setup`

That's it!

## Development

To start your development server you simply need to run `bin/server`. You will
need to create a bot user and set the `SLACK_BOT_OAUTH_TOKEN` env variable.

## Contributing

Feel free to contribute to this nonsense. Just don't forget to follow the
`CONTRIBUTING.md` guidelines and the project's `CODE_OF_CONDUCT.md`

### To Do

* [ ] Move threshold and channel configuration out of the config files and into
  bot commands.
* [ ] Save thread replies to the database.
* [ ] Create an explorer app to see the various question and reply threads.
