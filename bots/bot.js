var outputChannel = config['outputChannel']

function handleMessage(message) {
  if (!message.metadata) {
    return;
  }
}

function channelManager(subId, message) {
  if (subId === 'manager') {
    handleMessage(message);
  } else {
    console.info('unknown id', subId)
  }
}

function onMessage(subId, message) {
  channelManager(subId, message)
}
