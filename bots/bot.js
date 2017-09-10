var outputChannel = config['outputChannel']

function onMessage(channel, message) {
  rtm.publish(outputChannel, message)
}
