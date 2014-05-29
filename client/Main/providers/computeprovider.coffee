class ComputeProvider extends KDObject

  @providers = KD.config.providers

  @fetchStacks = (callback = noop)->

    if @stacks
      callback null, @stacks
      info "Stacks returned from cache."
      return

    KD.remote.api.JStack.some {}, (err, stacks = [])->
      return callback err  if err?
      callback null, ComputeProvider.stacks = stacks


  @fetchMachines = (callback)->

    @fetchStacks (err, stacks)->
      return callback err  if err?

      machines = []
      stacks.forEach (stack)->
        stack.machines.forEach (machine)->
          machines.push new Machine { machine }

      callback null, machines


  @credentialsFor = (provider, callback)->
    KD.remote.api.JCredential.some { provider }, callback

  @fetchAvailable = (options, callback)->
    KD.remote.api.ComputeProvider.fetchAvailable options, callback

  @fetchExisting = (options, callback)->
    KD.remote.api.ComputeProvider.fetchExisting options, callback

  @create = (options, callback)->
    KD.remote.api.ComputeProvider.create options, callback

  @createDefaultStack = ->
    KD.remote.api.ComputeProvider.createGroupStack (err, stack)->
      return if KD.showError err

      delete ComputeProvider.stacks
      KD.singletons.mainController.emit "renderStacks"


class Machine extends KDObject

  constructor:(options = {})->

    { machine } = options
    unless machine?.bongo_?.constructorName is 'JMachine'
      throw new Error 'Data should be a JMachine instance'

    delete options.machine
    super options, machine

    { @label, @publicAddress, @state } = @jMachine = @getData()



    # kayt = null
    # KD.singletons.kontrol.fetchKite(
    #   query:
    #     username:"gokmen"
    #     name: "klient"
    #     environment: "public-host"
    # ).then (oskite)->
    #   log {oskite}
    #   kayt = oskite
    #   oskite.connect()
    #   oskite.tell "exec", [command : "ls /"]
    # .then log, warn