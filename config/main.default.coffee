traverse              = require 'traverse'
log                   = console.log
fs                    = require 'fs'
os                    = require 'os'
path                  = require 'path'
{ isAllowed }         = require '../deployment/grouptoenvmapping'

Configuration = (options={}) ->

  domains =
    base  : 'koding.com'
    mail  : 'koding.com'
    main  : 'dev.koding.com'
    port  : '8090'

  defaultEmail = "hello@#{domains.mail}"

  boot2dockerbox = if os.type() is "Darwin" then "192.168.59.103" else "localhost"

  # Softlayer Provider Keys
  slKeys       =
    vm_kloud   :
      username : ''
      apiKey   : ''

  # AWS Keys that is required for Kloud
  awsKeys =
    # s3 full access
    worker_terraformer:
      accessKeyId     : ""
      secretAccessKey : ""

    # s3 put only to koding-client bucket
    worker_koding_client_s3_put_only:
      accessKeyId     : ""
      secretAccessKey : ""

    # admin
    worker_test:
      accessKeyId     : ""
      secretAccessKey : ""

    # s3 put only
    worker_test_data_exporter:
      accessKeyId     : ""
      secretAccessKey : ""

    # AmazonRDSReadOnlyAccess
    worker_rds_log_parser:
      accessKeyId     : ""
      secretAccessKey : ""

    # ELB & EC2 -> AmazonEC2ReadOnlyAccess
    worker_multi_ssh:
      accessKeyId     : ""
      secretAccessKey : ""

    # AmazonEC2FullAccess
    worker_test_instance_launcher:
      accessKeyId     : ""
      secretAccessKey : ""

    # CloudWatchReadOnlyAccess
    vm_vmwatcher:     # vm_vmwatcher_dev
      accessKeyId     : ""
      secretAccessKey : ""

    # KloudPolicy
    vm_kloud:         # vm_kloud_dev
      accessKeyId     : ""
      secretAccessKey : ""

    # TunnelProxyPolicy
    worker_tunnelproxymanager: # Name worker_tunnelproxymanager_dev
      accessKeyId     : ""
      secretAccessKey : ""

    # Encryption and Storage on S3
    worker_sneakerS3 :
      accessKeyId     : ""
      secretAccessKey : ""

  publicPort          = options.publicPort     or "8090"
  hostname            = options.hostname       or "dev.koding.com"
  protocol            = options.protocol       or "http:"
  publicHostname      = options.publicHostname or "#{protocol}//#{hostname}"
  region              = options.region         or 'default'
  configName          = options.configName     or 'default'
  environment         = options.environment    or 'default'
  projectRoot         = options.projectRoot    or path.join __dirname, '/..'
  version             = options.version        or "2.0" # TBD
  branch              = options.branch         or "cake-rewrite"
  build               = options.build          or "1111"
  tunnelUrl           = options.tunnelUrl      or "http://devtunnelproxy.koding.com" # this is ok for now
  githubapi           =
    debug             : yes
    timeout           : 5000
    userAgent         : 'Koding-Bridge-Dev'

  mongo               = "#{boot2dockerbox}:27017/koding"
  etcd                = "#{boot2dockerbox}:4001"

  redis               = { host:     "#{boot2dockerbox}"                           , port:               "6379"                                  , db:                 0                         }
  redis.url           = "#{redis.host}:#{redis.port}"

  rabbitmq            = { host:     "#{boot2dockerbox}"                           , port:               5672                                    , apiPort:            15672                       , login:           "guest"                              , password: "guest"                     , vhost:         "/"                                    }
  mq                  = { host:     "#{rabbitmq.host}"                            , port:               rabbitmq.port                           , apiAddress:         "#{rabbitmq.host}"          , apiPort:         "#{rabbitmq.apiPort}"                , login:    "#{rabbitmq.login}"         , componentUser: "#{rabbitmq.login}"                      , password:       "#{rabbitmq.password}"                   , heartbeat:       10           , vhost:        "#{rabbitmq.vhost}" }

  scheme = 'http'
  _port  = if publicPort is '80' then '' else publicPort
  host   = options.host or "#{options.hostname}:#{_port}"

  local = "127.0.0.1"
  if publicPort isnt '80'
    local = "#{local}:#{publicPort}"

  customDomain        = { public: "#{scheme}://#{host}", public_: host, local: "http://#{local}", local_: "#{local}", host: "http://#{hostname}", port: 8090 }

  email               = { host:     "#{customDomain.public_}"                     , defaultFromMail:    defaultEmail                            , defaultFromName:    'Koding'                    , forcedRecipientEmail: defaultEmail                    , forcedRecipientUsername: "admin" }
  kontrol             = { url:      "#{customDomain.public}/kontrol/kite"         , port:               3000                                    , useTLS:             no                          , certFile:        ""                                   , keyFile:  ""                          , publicKeyFile: "./certs/test_kontrol_rsa_public.pem"    , privateKeyFile: "./certs/test_kontrol_rsa_private.pem"}
  broker              = { name:     "broker"                                      , serviceGenericName: "broker"                                , ip:                 ""                          , webProtocol:     "http:"                              , host:     "#{customDomain.public}"    , port:          8008                                     , certFile:       ""                                       , keyFile:         ""          , authExchange: "auth"                , authAllExchange: "authAll" , failoverUri: "#{customDomain.public}" }
  regions             = { kodingme: "#{configName}"                               , vagrant:            "vagrant"                               , sj:                 "sj"                        , aws:             "aws"                                , premium:  "vagrant"                 }
  algolia             = { appId:    ''                                            , indexSuffix:        ".#{ os.hostname() }"                   }
  algoliaSecret       = { appId:    "#{algolia.appId}"                            , indexSuffix:        algolia.indexSuffix                     , apiSecretKey:       ''                          , apiSearchOnlyKey: '' }
  postgres            = { host:     "#{boot2dockerbox}"                           , port:               "5432"                                  , username:           "socialapp201506"           , password:        "socialapp201506"                    , dbname:   "social"                  }
  kontrolPostgres     = { host:     "#{boot2dockerbox}"                           , port:               5432                                    , username:           "kontrolapp201506"          , password:        "kontrolapp201506"                   , dbname:   "social"                    , connecttimeout: 20 }
  kiteHome            = "#{projectRoot}/kite_home/koding"
  pubnub              = { publishkey: "pub-c-5b987056-ef0f-457a-aadf-87b0488c1da1", subscribekey:       "sub-c-70ab5d36-0b13-11e5-8104-0619f8945a4f"  , secretkey: "sec-c-MWFhYTAzZWUtYzg4My00ZjAyLThiODEtZmI0OTFkOTk0YTE0"                               , serverAuthKey: "46fae3cc-9344-4edb-b152-864ba567980c7960b1d8-31dd-4722-b0a1-59bf878bd551"       , origin: "pubsub.pubnub.com"                              , enabled:  yes                         }
  gatekeeper          = { host:     "localhost"                                   , port:               "7200"                                  , pubnub: pubnub                                }
  integration         = { host:     "localhost"                                   , port:               "7300"                                  , url: "#{customDomain.public}/api/integration" }
  webhookMiddleware   = { host:     "localhost"                                   , port:               "7350"                                  , url: "#{customDomain.public}/api/webhook"     }
  paymentwebhook      = { port:     "6600"                                        , debug:              false                                   , secretKey: "paymentwebhooksecretkey-dev"      }
  tokbox              = { apiKey:   ""                                            , apiSecret:          "" }
  recaptcha           = { enabled: no }

  # configuration for socialapi, order will be the same with
  # ./go/src/socialapi/config/configtypes.go

  kloudPort           = 5500
  kloud               = { port : kloudPort, userPrivateKeyFile: "./certs/kloud/dev/kloud_dev_rsa.pem", userPublicKeyfile: "./certs/kloud/dev/kloud_dev_rsa.pub",  privateKeyFile : kontrol.privateKeyFile , publicKeyFile: kontrol.publicKeyFile, kontrolUrl: kontrol.url, registerUrl : "#{customDomain.public}/kloud/kite", secretKey :  "", address : "http://localhost:#{kloudPort}/kite", tunnelUrl : "#{tunnelUrl}", klientUrl : "https://s3.amazonaws.com/koding-klient/development/latest/klient.deb"}
  terraformer         = { port : 2300     , bucket:             "koding-terraformer-state-dev",        localstorepath: "#{projectRoot}/go/data/terraformer" }

  googleapiServiceAccount =
    clientId              : ''
    clientSecret          : ''
    serviceAccountEmail   : ''
    serviceAccountKeyFile : ''

  segment = ''

  github =
    clientId     : ""
    clientSecret : ""
    redirectUri  : "http://dev.koding.com:8090/-/oauth/github/callback"

  mailgun =
    domain        : ''
    privateKey    : ''
    publicKey     : ''
    unsubscribeURL: ''

  slack  =
    clientId          : ''
    clientSecret      : ''
    redirectUri       : ''
    verificationToken : ''

  sneakerS3 =
    awsSecretAccessKey  : ''
    awsAccessKeyId      : ''
    sneakerS3Path       : ''
    sneakerMasterKey    : ''
    awsRegion           : ''

  # if you want to disable a feature add here with "true" value do not forget to
  # add corresponding go struct properties
  # "true" value is used because of Go's default value for boolean properties is
  # false, so all the features are enabled as default, you dont have to define
  # features everywhere
  disabledFeatures =
    moderation : yes
    teams      : no
    botchannel : yes

  socialapi =
    proxyUrl                : "#{customDomain.local}/api/social"
    port                    : "7000"
    configFilePath          : "#{projectRoot}/go/src/socialapi/config/default.toml"
    postgres                : postgres
    mq                      : mq
    redis                   : url: redis.url
    mongo                   : mongo
    environment             : environment
    region                  : region
    hostname                : host
    protocol                : protocol
    email                   : email
    sitemap                 : { redisDB: 0, updateInterval:  "1m" }
    algolia                 : algoliaSecret
    limits                  : { messageBodyMinLen: 1, postThrottleDuration: "15s", postThrottleCount: 30 }
    eventExchangeName       : "BrokerMessageBus"
    disableCaching          : no
    debug                   : no
    stripe                  : { secretToken : '' }
    paypal                  : { username: '', password: '', signature: '', returnUrl: "#{customDomain.public}/-/payments/paypal/return", cancelUrl: "#{customDomain.public}/-/payments/paypal/cancel", isSandbox: yes }
    gatekeeper              : gatekeeper
    integration             : integration
    webhookMiddleware       : webhookMiddleware
    customDomain            : customDomain
    kloud                   : { secretKey: kloud.secretKey, address: kloud.address }
    paymentwebhook          : paymentwebhook
    googleapiServiceAccount : googleapiServiceAccount
    github                  : github
    slack                   : slack
    sneakerS3               : sneakerS3
    geoipdbpath             : "#{projectRoot}/go/data/geoipdb"
    segment                 : segment
    disabledFeatures        : disabledFeatures
    janitor                 : { port: "6700", secretKey: '' }
    mailgun                 : mailgun

  userSitesDomain     = "dev.koding.io"
  hubspotPageURL      = "http://www.koding.com"

  socialQueueName     = "koding-social-#{configName}"
  autoConfirmAccounts = yes

  tunnelserver =
    port            : 80
    basevirtualhost : "koding.me"
    hostedzone      : "koding.me"

  KONFIG =
    configName                     : configName
    environment                    : environment
    ebEnvName                      : options.ebEnvName
    runGoWatcher                   : options.runGoWatcher
    regions                        : regions
    region                         : region
    hostname                       : host
    protocol                       : protocol
    publicPort                     : publicPort
    publicHostname                 : publicHostname
    version                        : version
    awsKeys                        : awsKeys
    broker                         : broker
    uri                            : address: customDomain.public
    tunnelserver                   : tunnelserver
    userSitesDomain                : userSitesDomain
    hubspotPageURL                 : hubspotPageURL
    autoConfirmAccounts            : autoConfirmAccounts
    projectRoot                    : projectRoot
    socialapi                      : socialapi
    mongo                          : mongo
    kiteHome                       : kiteHome
    redis                          : redis.url
    monitoringRedis                : redis.url
    misc                           : {claimGlobalNamesForUsers: no , debugConnectionErrors: yes}
    githubapi                      : githubapi
    recaptcha                      : {enabled : recaptcha.enabled  , url : "https://www.google.com/recaptcha/api/siteverify", secret : '' }
    # TODO: average request count per hour for a user should be measured and a reasonable limit should be set
    nodejsRateLimiter              : {enabled : no, guestRules : [{ interval: 3600, limit: 5000 }], userRules : [{ interval: 3600, limit: 10000 }]} # limit: request limit per rate limit window, interval: rate limit window duration in seconds

    # -- WORKER CONFIGURATION -- #

    vmwatcher                      : {port          : "6400"              , awsKey    : awsKeys.vm_vmwatcher.accessKeyId     , awsSecret : awsKeys.vm_vmwatcher.secretAccessKey , kloudSecretKey : kloud.secretKey , kloudAddr : kloud.address, connectToKlient: false, debug: false, mongo: mongo, redis: redis.url, secretKey: '' }
    gowebserver                    : {port          : 6500}
    gatheringestor                 : {port          : 6800}
    webserver                      : {port          : 8080                , useCacheHeader: no                     , kitePort          : 8860}
    authWorker                     : {login         : "#{rabbitmq.login}" , queueName : socialQueueName+'auth'     , authExchange      : "auth"                                  , authAllExchange : "authAll"                                      , port  : 9530 }
    mq                             : mq
    emailWorker                    : {cronInstant   : '*/10 * * * * *'    , cronDaily : '0 10 0 * * *'             , run               : no                                      , forcedRecipientEmail: email.forcedRecipientEmail, forcedRecipientUsername: email.forcedRecipientUsername               , maxAge: 3      , port  : 9540 }
    elasticSearch                  : {host          : "#{boot2dockerbox}" , port      : 9200                       , enabled           : no                                      , queue           : "elasticSearchFeederQueue"}
    social                         : {port          : 3030                , login     : "#{rabbitmq.login}"        , queueName         : socialQueueName                         , kitePort        : 8760 }
    email                          : email
    newkites                       : {useTLS        : no                  , certFile  : ""                         , keyFile: "#{projectRoot}/kite_home/koding/kite.key"}
    boxproxy                       : {port          : 8090 }
    sourcemaps                     : {port          : 3526 }
    rerouting                      : {port          : 9500 }
    emailer                        : {port          : 9600 }
    kloud                          : kloud
    terraformer                    : terraformer
    kontrol                        : kontrol
    newkontrol                     : kontrol
    gatekeeper                     : gatekeeper

    # -- MISC SERVICES --#
    recurly                        : {apiKey        : "", loggedRequests: "/^(subscriptions|transactions)/"}
    opsview                        : {push          : no                                             , host          : ''                                           , bin: null                                                                             , conf: null}
    github                         : github
    odesk                          : {key           : ""             , secret        : ''           , request_url : "https://www.upwork.com/api/auth/v1/oauth/token/request", access_url: "https://www.upwork.com/api/auth/v1/oauth/token/access" , secret_url: "https://www.upwork.com/services/api/auth?oauth_token=" , version: "1.0"                                                    , signature: "HMAC-SHA1" , redirect_uri : "#{customDomain.host}:#{customDomain.port}/-/oauth/odesk/callback"}
    facebook                       : {clientId      : ""             , clientSecret  : ''           , redirectUri : "http://dev.koding.com:8090/-/oauth/facebook/callback"}
    slack                          : slack
    sneakerS3                      : sneakerS3
    google                         : {client_id     : ""                                    , client_secret : ""                                                    , redirect_uri : "http://dev.koding.com:8090/-/oauth/google/callback" }
    twitter                        : {key           : ""                                             , secret        : "" , redirect_uri : "http://dev.koding.com:8090/-/oauth/twitter/callback"                  , request_url  : "https://twitter.com/oauth/request_token"           , access_url   : "https://twitter.com/oauth/access_token"            , secret_url: "https://twitter.com/oauth/authenticate?oauth_token=" , version: "1.0"         , signature: "HMAC-SHA1"}
    linkedin                       : {client_id     : ""                               , client_secret : ""                           , redirect_uri : "http://dev.koding.com:8090/-/oauth/linkedin/callback"}
    datadog                        : {api_key       : ""             , app_key       : ""}
    sessionCookie                  : {maxAge        : 1000 * 60 * 60 * 24 * 14                       , secure        : no}
    aws                            : {key           : ""                                             , secret        : ''}
    embedly                        : {apiKey        : "" }
    iframely                       : {apiKey        : ""                       , url           : 'http://iframe.ly/api/oembed'}
    troubleshoot                   : {recipientEmail: defaultEmail }
    rollbar                        : ""
    segment                        : segment
    googleapiServiceAccount        : googleapiServiceAccount
    siftScience                    : ''
    tokbox                         : tokbox
    disabledFeatures               : disabledFeatures
    contentRotatorUrl              : 'http://koding.github.io'
    collaboration                  : {timeout: 1 * 60 * 1000}
    client                         : {watch: yes                                                     , version: version                                              , includesPath:'client' , indexMaster: "index-master.html" , index: "default.html" , useStaticFileServer: no , staticFilesBaseUrl: "#{customDomain.public}:#{customDomain.port}"}
    jwt                            : {secret: 'somesecretkeyhere'       , confirmExpiresInMinutes: 10080  } # 7 days
    papertrail                     : {destination: ''                   , groupId: 2199093                                              , token: '' }
    sendEventsToSegment            : options.sendEventsToSegment
    mailgun                        : mailgun
    domains                        : domains

  #-------- runtimeOptions: PROPERTIES SHARED WITH BROWSER --------#
  # NOTE: when you add to runtime options below, be sure to modify
  # `RuntimeOptions` struct in `go/src/koding/tools/config/config.go`

  KONFIG.client.runtimeOptions =
    kites                : require './kites.coffee'           # browser passes this version information to kontrol , so it connects to correct version of the kite.
    algolia              : algolia
    suppressLogs         : no
    authExchange         : "auth"
    environment          : environment                        # this is where browser knows what kite environment to query for
    version              : version
    resourceName         : socialQueueName
    userSitesDomain      : userSitesDomain
    socialApiUri         : "/xhr"
    apiUri               : null
    sourceMapsUri        : "/sourcemaps"
    mainUri              : null
    broker               : uri  : "/subscribe"
    uploadsUri           : 'https://koding-uploads.s3.amazonaws.com'
    uploadsUriForGroup   : 'https://koding-groups.s3.amazonaws.com'
    fileFetchTimeout     : 1000 * 15
    userIdleMs           : 1000 * 60 * 5
    embedly              : {apiKey       : KONFIG.embedly.apiKey}
    github               : {clientId     : github.clientId}
    newkontrol           : {url          : "#{kontrol.url}"}
    sessionCookie        : KONFIG.sessionCookie
    troubleshoot         : {idleTime     : 1000 * 60 * 60           , externalUrl  : "https://s3.amazonaws.com/koding-ping/healthcheck.json"}
    stripe               : { token: '' }
    externalProfiles     :
      google             : {nicename: 'Google'  }
      linkedin           : {nicename: 'LinkedIn'}
      twitter            : {nicename: 'Twitter' }
      odesk              : {nicename: 'Upwork'  , urlLocation: 'info.profile_url' }
      facebook           : {nicename: 'Facebook', urlLocation: 'link'             }
      github             : {nicename: 'GitHub'  , urlLocation: 'html_url'         }
    entryPoint           : {slug:'koding'       , type:'group'}
    siftScience          : ''
    paypal               : { formUrl: 'https://www.sandbox.paypal.com/incontext' }
    pubnub               : { subscribekey: pubnub.subscribekey , ssl: no,  enabled: yes     }
    collaboration        : KONFIG.collaboration
    paymentBlockDuration : 2 * 60 * 1000 # 2 minutes
    tokbox               : { apiKey: tokbox.apiKey }
    disabledFeatures     : disabledFeatures
    integration          : { url: "#{integration.url}" }
    webhookMiddleware    : { url: "#{webhookMiddleware.url}" }
    google               : apiKey: ''
    recaptcha            : { enabled : recaptcha.enabled, key : ""}
    sendEventsToSegment  : KONFIG.sendEventsToSegment
    domains              : domains

    # NOTE: when you add to runtime options above, be sure to modify
    # `RuntimeOptions` struct in `go/src/koding/tools/config/config.go`

    # END: PROPERTIES SHARED WITH BROWSER #


  #--- RUNTIME CONFIGURATION: WORKERS AND KITES ---#
  GOBIN = "#{projectRoot}/go/bin"
  GOPATH= "#{projectRoot}/go"


  # THESE COMMANDS WILL EXECUTE IN PARALLEL.

  disabledWorkers = [
    "algoliaconnector"
    "paymentwebhook"
  # "terraformer"
  # "gatekeeper"
    "vmwatcher"
  # "webhook"
  # "kloud"
  ]

  KONFIG.workers =
    gowebserver         :
      group             : "webserver"
      ports             :
         incoming       : "#{KONFIG.gowebserver.port}"
      supervisord       :
        command         :
          run           : "#{GOBIN}/go-webserver -c #{configName}"
          watch         : "#{GOBIN}/watcher -run koding/go-webserver -c #{configName}"
      nginx             :
        locations       : [ location: "~^/IDE/.*" ]
      healthCheckURL    : "http://localhost:#{KONFIG.gowebserver.port}/healthCheck"
      versionURL        : "http://localhost:#{KONFIG.gowebserver.port}/version"

    kontrol             :
      group             : "environment"
      ports             :
        incoming        : "#{kontrol.port}"
      supervisord       :
        command         : "#{GOBIN}/kontrol -region #{region} -machines #{etcd} -environment #{environment} -mongourl #{KONFIG.mongo} -port #{kontrol.port} -privatekey #{kontrol.privateKeyFile} -publickey #{kontrol.publicKeyFile} -storage postgres -postgres-dbname #{kontrolPostgres.dbname} -postgres-host #{kontrolPostgres.host} -postgres-port #{kontrolPostgres.port} -postgres-username #{kontrolPostgres.username} -postgres-password #{kontrolPostgres.password} -postgres-connecttimeout #{kontrolPostgres.connecttimeout}"
      nginx             :
        websocket       : yes
        locations       : [
          {
            location    : "~^/kontrol/(.*)"
            proxyPass   : "http://kontrol/$1$is_args$args"
          }
        ]
      healthCheckURL    : "http://localhost:#{KONFIG.kontrol.port}/healthCheck"
      versionURL        : "http://localhost:#{KONFIG.kontrol.port}/version"

    kloud               :
      group             : "environment"
      ports             :
        incoming        : "#{KONFIG.kloud.port}"
      supervisord       :
        command         : "#{GOBIN}/kloud -networkusageendpoint http://localhost:#{KONFIG.vmwatcher.port} -planendpoint #{socialapi.proxyUrl}/payments/subscriptions -hostedzone #{userSitesDomain} -region #{region} -environment #{environment} -port #{KONFIG.kloud.port}  -userprivatekey #{KONFIG.kloud.userPrivateKeyFile} -userpublickey #{KONFIG.kloud.userPublicKeyfile}  -publickey #{kontrol.publicKeyFile} -privatekey #{kontrol.privateKeyFile} -kontrolurl #{kontrol.url}  -registerurl #{KONFIG.kloud.registerUrl} -mongourl #{KONFIG.mongo} -prodmode=#{configName is "prod"} -awsaccesskeyid=#{awsKeys.vm_kloud.accessKeyId} -awssecretaccesskey=#{awsKeys.vm_kloud.secretAccessKey} -slusername=#{slKeys.vm_kloud.username} -slapikey=#{slKeys.vm_kloud.apiKey} -janitorsecretkey=#{socialapi.janitor.secretKey} -vmwatchersecretkey=#{KONFIG.vmwatcher.secretKey} -paymentwebhooksecretkey=#{paymentwebhook.secretKey} -tunnelurl #{KONFIG.kloud.tunnelUrl} -klienturl #{KONFIG.kloud.klientUrl}"
      nginx             :
        websocket       : yes
        locations       : [
          {
            location    : "~^/kloud/(.*)"
            proxyPass   : "http://kloud/$1$is_args$args"
          }
        ]
      healthCheckURL    : "http://localhost:#{KONFIG.kloud.port}/healthCheck"
      versionURL        : "http://localhost:#{KONFIG.kloud.port}/version"

    terraformer         :
      group             : "environment"
      supervisord       :
        command         : "#{GOBIN}/terraformer -port #{KONFIG.terraformer.port} -region #{region} -environment  #{environment} -aws-key #{awsKeys.worker_terraformer.accessKeyId} -aws-secret #{awsKeys.worker_terraformer.secretAccessKey} -aws-bucket #{KONFIG.terraformer.bucket} -localstorepath #{KONFIG.terraformer.localstorepath}"
      healthCheckURL    : "http://localhost:#{KONFIG.terraformer.port}/healthCheck"
      versionURL        : "http://localhost:#{KONFIG.terraformer.port}/version"

    broker              :
      group             : "webserver"
      ports             :
        incoming        : "#{KONFIG.broker.port}"
      supervisord       :
        command         :
          run           : "#{GOBIN}/broker -c #{configName}"
          watch         : "#{GOBIN}/watcher -run koding/broker -c #{configName}"
      nginx             :
        websocket       : yes
        locations       : [
          { location    : "/websocket" }
          { location    : "~^/subscribe/.*" }
        ]
      healthCheckURL    : "http://localhost:#{KONFIG.broker.port}/info"
      versionURL        : "http://localhost:#{KONFIG.broker.port}/version"

    rerouting           :
      group             : "webserver"
      supervisord       :
        command         :
          run           : "#{GOBIN}/rerouting -c #{configName}"
          watch         : "#{GOBIN}/watcher -run koding/rerouting -c #{configName}"
      healthCheckURL    : "http://localhost:#{KONFIG.rerouting.port}/healthCheck"
      versionURL        : "http://localhost:#{KONFIG.rerouting.port}/version"

    authworker          :
      group             : "webserver"
      supervisord       :
        command         : "./watch-node #{projectRoot}/workers/auth/index.js -c #{configName} -p #{KONFIG.authWorker.port} --disable-newrelic"
      healthCheckURL    : "http://localhost:#{KONFIG.authWorker.port}/healthCheck"
      versionURL        : "http://localhost:#{KONFIG.authWorker.port}/version"

    emailerworker       :
      group             : "default"
      supervisord       :
        command         : "./watch-node #{projectRoot}/workers/emailer/index.js -c #{configName} -p #{KONFIG.emailer.port}"
      healthCheckURL    : "http://localhost:#{KONFIG.emailer.port}/healthCheck"
      versionURL        : "http://localhost:#{KONFIG.emailer.port}/version"

    sourcemaps          :
      group             : "webserver"
      ports             :
        incoming        : "#{KONFIG.sourcemaps.port}"
      nginx             :
        locations       : [ { location : "/sourcemaps" } ]
      supervisord       :
        command         : "./watch-node #{projectRoot}/servers/sourcemaps/index.js -c #{configName} -p #{KONFIG.sourcemaps.port} --disable-newrelic"

    webserver           :
      group             : "webserver"
      ports             :
        incoming        : "#{KONFIG.webserver.port}"
        outgoing        : "#{KONFIG.webserver.kitePort}"
      supervisord       :
        command         : "./watch-node #{projectRoot}/servers/index.js -c #{configName} -p #{KONFIG.webserver.port}                 --disable-newrelic --kite-port=#{KONFIG.webserver.kitePort} --kite-key=#{kiteHome}/kite.key"
      nginx             :
        locations       : [
          {
            location    : "~ /-/api/(.*)"
            proxyPass   : "http://webserver/-/api/$1$is_args$args"
          }
          {
            location    : "/"
          }
        ]

    socialworker        :
      group             : "webserver"
      ports             :
        incoming        : "#{KONFIG.social.port}"
        outgoing        : "#{KONFIG.social.kitePort}"
      supervisord       :
        command         : "./watch-node #{projectRoot}/workers/social/index.js -c #{configName} -p #{KONFIG.social.port} -r #{region} --disable-newrelic --kite-port=#{KONFIG.social.kitePort} --kite-key=#{kiteHome}/kite.key"
      nginx             :
        locations       : [ location: "/xhr" ]
      healthCheckURL    : "http://localhost:#{KONFIG.social.port}/healthCheck"
      versionURL        : "http://localhost:#{KONFIG.social.port}/version"

    paymentwebhook      :
      group             : "socialapi"
      ports             :
        incoming        : paymentwebhook.port
      supervisord       :
        command         :
          run           : "#{GOBIN}/paymentwebhook -c #{socialapi.configFilePath} -kite-init=true"
          watch         : "make -C #{projectRoot}/go/src/socialapi paymentwebhookdev config=#{socialapi.configFilePath}"
      healthCheckURL    : "http://localhost:#{paymentwebhook.port}/healthCheck"
      versionURL        : "http://localhost:#{paymentwebhook.port}/version"
      nginx             :
        locations       : [
          { location    : "= /-/payments/stripe/webhook" },
        ]

    vmwatcher           :
      group             : "environment"
      instances         : 1
      ports             :
        incoming        : "#{KONFIG.vmwatcher.port}"
      supervisord       :
        command         :
          run           : "#{GOBIN}/vmwatcher"
          watch         : "#{GOBIN}/watcher -run koding/vmwatcher"
      nginx             :
        locations       : [ { location: "/vmwatcher" } ]
      healthCheckURL    : "http://localhost:#{KONFIG.vmwatcher.port}/healthCheck"
      versionURL        : "http://localhost:#{KONFIG.vmwatcher.port}/version"

    socialapi:
      group             : "socialapi"
      instances         : 1
      ports             :
        incoming        : "#{socialapi.port}"
      supervisord       :
        command         :
          run           : "#{GOBIN}/api -c #{socialapi.configFilePath} -port=#{socialapi.port}"
          watch         : "make -C #{projectRoot}/go/src/socialapi apidev config=#{socialapi.configFilePath}"
      healthCheckURL    : "#{socialapi.proxyUrl}/healthCheck"
      versionURL        : "#{socialapi.proxyUrl}/version"
      nginx             :
        locations       : [
          # location ordering is important here. if you are going to need to change it or
          # add something new, thoroughly test it in sandbox. Most of the problems are not occuring
          # in dev environment
          {
            location    : "~ /api/social/channel/(.*)/history/count"
            proxyPass   : "http://socialapi/channel/$1/history/count$is_args$args"
          }
          {
            location    : "~ /api/social/channel/(.*)/history"
            proxyPass   : "http://socialapi/channel/$1/history$is_args$args"
          }
          {
            location    : "~ /api/social/channel/(.*)/list"
            proxyPass   : "http://socialapi/channel/$1/list$is_args$args"
          }
          {
            location    : "~ /api/social/channel/by/(.*)"
            proxyPass   : "http://socialapi/channel/by/$1$is_args$args"
          }
          {
            location    : "~ /api/social/channel/(.*)/notificationsetting"
            proxyPass   : "http://socialapi/channel/$1/notificationsetting$is_args$args"
          }
          {
            location    : "~ /api/social/notificationsetting/(.*)"
            proxyPass   : "http://socialapi/notificationsetting/$1$is_args$args"
          }
          {
            location    : "~ /api/social/collaboration/ping"
            proxyPass   : "http://socialapi/collaboration/ping$1$is_args$args"
          }
          {
            location    : "~ /api/social/search-key"
            proxyPass   : "http://socialapi/search-key$1$is_args$args"
          }
          {
            location    : "~ /api/social/sshkey"
            proxyPass   : "http://socialapi/sshkey$1$is_args$args"
          }
          {
            location    : "~ /api/social/moderation/(.*)"
            proxyPass   : "http://socialapi/moderation/$1$is_args$args"
          }
          {
            location    : "~ /api/social/account/channels"
            proxyPass   : "http://socialapi/account/channels$is_args$args"
          }
          {
            location    : "~* ^/api/social/slack/(.*)"
            proxyPass   : "http://socialapi/slack/$1$is_args$args"
            extraParams : [ "proxy_buffering off;" ] # appearently slack sends a big header
          }
          {
            location    : "~ /api/social/(.*)"
            proxyPass   : "http://socialapi/$1$is_args$args"
            internalOnly: yes
          }
          {
            location    : "~ /sitemap(.*).xml"
            proxyPass   : "http://socialapi/sitemap$1.xml"
          }

        ]

    dailyemailnotifier  :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/dailyemail -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/email/dailyemail -watch socialapi/workers/email/dailyemail -c #{socialapi.configFilePath}"

    algoliaconnector    :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/algoliaconnector -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/algoliaconnector -watch socialapi/workers/algoliaconnector -c #{socialapi.configFilePath}"

    notification        :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/notification -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/notification -watch socialapi/workers/notification -c #{socialapi.configFilePath}"

    popularpost         :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/popularpost -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/popularpost -watch socialapi/workers/popularpost -c #{socialapi.configFilePath}"

    populartopic        :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/populartopic -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/populartopic -watch socialapi/workers/populartopic -c #{socialapi.configFilePath}"

    pinnedpost          :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/pinnedpost -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/pinnedpost -watch socialapi/workers/pinnedpost -c #{socialapi.configFilePath}"

    realtime            :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/realtime -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/realtime -watch socialapi/workers/realtime -c #{socialapi.configFilePath}"

    sitemapfeeder       :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/sitemapfeeder -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/sitemapfeeder -watch socialapi/workers/sitemapfeeder -c #{socialapi.configFilePath}"

    sitemapgenerator    :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/sitemapgenerator -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/sitemapgenerator -watch socialapi/workers/sitemapgenerator -c #{socialapi.configFilePath}"

    activityemail       :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/activityemail -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/email/activityemail -watch socialapi/workers/email/activityemail -c #{socialapi.configFilePath}"

    topicfeed           :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/topicfeed -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/topicfeed -watch socialapi/workers/topicfeed -c #{socialapi.configFilePath}"

    trollmode           :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/trollmode -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/trollmode -watch socialapi/workers/trollmode -c #{socialapi.configFilePath}"

    privatemessageemailfeeder:
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/privatemessageemailfeeder -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/email/privatemessageemailfeeder -watch socialapi/workers/email/privatemessageemailfeeder -c #{socialapi.configFilePath}"

    privatemessageemailsender:
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/privatemessageemailsender -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/email/privatemessageemailsender -watch socialapi/workers/email/privatemessageemailsender -c #{socialapi.configFilePath}"

    topicmoderation     :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/topicmoderation -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/topicmoderation -watch socialapi/workers/topicmoderation -c #{socialapi.configFilePath}"

    collaboration       :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/collaboration -c #{socialapi.configFilePath} -kite-init=true"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/collaboration -watch socialapi/workers/collaboration -c #{socialapi.configFilePath} -kite-init=true"

    gatekeeper          :
      group             : "socialapi"
      ports             :
        incoming        : "#{gatekeeper.port}"
      supervisord       :
        command         :
          run           : "#{GOBIN}/gatekeeper -c #{socialapi.configFilePath}"
          watch         : "make -C #{projectRoot}/go/src/socialapi gatekeeperdev config=#{socialapi.configFilePath}"
      healthCheckURL    : "#{customDomain.local}/api/gatekeeper/healthCheck"
      versionURL        : "#{customDomain.local}/api/gatekeeper/version"
      nginx             :
        locations       : [
          location      : "~ /api/gatekeeper/(.*)"
          proxyPass     : "http://gatekeeper/$1$is_args$args"
        ]

    dispatcher          :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/dispatcher -c #{socialapi.configFilePath}"
          watch         : "make -C #{projectRoot}/go/src/socialapi dispatcherdev config=#{socialapi.configFilePath}"

    mailsender          :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/emailsender -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/emailsender -watch socialapi/workers/emailsender -c #{socialapi.configFilePath}"

    team                :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/team -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/team -watch socialapi/workers/team -c #{socialapi.configFilePath}"

    janitor             :
      group             : "environment"
      instances         : 1
      supervisord       :
        command         : "#{GOBIN}/janitor -c #{socialapi.configFilePath} -kite-init=true"
      healthCheckURL    : "http://localhost:#{socialapi.janitor.port}/healthCheck"
      versionURL        : "http://localhost:#{socialapi.janitor.port}/version"

    gatheringestor      :
      ports             :
        incoming        : KONFIG.gatheringestor.port
      group             : "environment"
      instances         : 1
      supervisord       :
        command         :
          run           : "#{GOBIN}/gatheringestor -c #{configName}"
          watch         : "#{GOBIN}/watcher -run koding/workers/gatheringestor -c #{configName}"
      healthCheckURL    : "http://localhost:#{KONFIG.gatheringestor.port}/healthCheck"
      versionURL        : "http://localhost:#{KONFIG.gatheringestor.port}/version"
      nginx             :
        locations       : [
          location      : "~ /-/ingestor/(.*)"
          proxyPass     : "http://gatheringestor/$1$is_args$args"
        ]

    integration         :
      group             : "socialapi"
      ports             :
        incoming        : "#{integration.port}"
      supervisord       :
        command         :
          run           : "#{GOBIN}/webhook -c #{socialapi.configFilePath}"
          watch         : "make -C #{projectRoot}/go/src/socialapi webhookdev config=#{socialapi.configFilePath}"
      healthCheckURL    : "#{customDomain.local}/api/integration/healthCheck"
      versionURL        : "#{customDomain.local}/api/integration/version"
      nginx             :
        locations       : [
          location      : "~ /api/integration/(.*)"
          proxyPass     : "http://integration/$1$is_args$args"
        ]

    webhook             :
      group             : "socialapi"
      ports             :
        incoming        : "#{webhookMiddleware.port}"
      supervisord       :
        command         :
          run           : "#{GOBIN}/webhookmiddleware -c #{socialapi.configFilePath}"
          watch         : "make -C #{projectRoot}/go/src/socialapi middlewaredev config=#{socialapi.configFilePath}"
      healthCheckURL    : "#{customDomain.local}/api/webhook/healthCheck"
      versionURL        : "#{customDomain.local}/api/webhook/version"
      nginx             :
        locations       : [
          location      : "~ /api/webhook/(.*)"
          proxyPass     : "http://webhook/$1$is_args$args"
        ]

    eventsender         :
      group             : "socialapi"
      supervisord       :
        command         :
          run           : "#{GOBIN}/eventsender -c #{socialapi.configFilePath}"
          watch         : "#{GOBIN}/watcher -run socialapi/workers/cmd/eventsender -watch socialapi/workers/eventsender -c #{socialapi.configFilePath}"

    contentrotator      :
      group             : "webserver"
      nginx             :
        locations       : [
          {
            location    : "~ /-/content-rotator/(.*)"
            proxyPass   : "#{KONFIG.contentRotatorUrl}/content-rotator/$1"
            extraParams : [ "resolver 8.8.8.8;" ]
          }
        ]

    tunnelproxymanager  :
      group             : "proxy"
      supervisord       :
        command         : "#{GOBIN}/tunnelproxymanager -ebenvname #{options.ebEnvName} -accesskeyid #{awsKeys.worker_tunnelproxymanager.accessKeyId} -secretaccesskey #{awsKeys.worker_tunnelproxymanager.secretAccessKey} -hostedzone-name #{tunnelUrl} -hostedzone-callerreference devtunnelproxy_hosted_zone_v0"

    tunnelserver        :
      group             : "proxy"
      supervisord       :
        command         : "#{GOBIN}/tunnelserver -accesskey #{awsKeys.worker_tunnelproxymanager.accessKeyId} -secretkey #{awsKeys.worker_tunnelproxymanager.secretAccessKey} -port #{tunnelserver.port} -basevirtualhost #{tunnelserver.basevirtualhost} -hostedzone #{tunnelserver.hostedzone}"
      ports             :
        incoming        : "#{tunnelserver.port}"
      healthCheckURL    : "http://tunnelserver/healthCheck"
      versionURL        : "http://tunnelserver/version"
      nginx             :
        websocket       : yes
        locations       : [
          {
            location    : "~ /tunnelserver/(.*)"
            proxyPass   : "http://tunnelserver/$1"
          }
        ]

    userproxies         :
      group             : "proxy"
      nginx             :
        websocket       : yes
        locations       : [
          {
            location    : '~ ^\\/-\\/prodproxy\\/(?<ip>.+?)\\/(?<rest>.*)'
            proxyPass   : 'http://$ip:56789/$rest'
            extraParams : [
              'proxy_read_timeout 21600s;'
              'proxy_send_timeout 21600s;'
            ]
          }
          {
            location    : '~ ^\\/-\\/devproxy\\/(?<ip>.+?)\\/(?<rest>.*)'
            proxyPass   : 'http://$ip:56789/$rest'
            extraParams : [
              'proxy_read_timeout 21600s;'
              'proxy_send_timeout 21600s;'
            ]
          }
          {
            location    : "~ ^\\/-\\/prodtunnel\\/(?<tunnel>.+?)\.#{tunnelserver.hostedzone}(?<rest>.*)"
            proxyPass   : "http://$tunnel.#{tunnelserver.hostedzone}$rest"
            host        : "$tunnel.#{tunnelserver.hostedzone}"
            extraParams : [
              'proxy_read_timeout 21600s;'
              'proxy_send_timeout 21600s;'
              'resolver 8.8.8.8;'
            ]
          }
          {
            location    : "~ ^\\/-\\/devtunnel\\/(?<tunnel>.+?)\.#{tunnelserver.hostedzone}(?<rest>.*)"
            proxyPass   : "http://$tunnel.#{tunnelserver.hostedzone}$rest"
            host        : "$tunnel.#{tunnelserver.hostedzone}"
            extraParams : [
              'proxy_read_timeout 21600s;'
              'proxy_send_timeout 21600s;'
              'resolver 8.8.8.8;'
            ]
          }
        ]



  KONFIG.supervisord =
    logdir   : "#{projectRoot}/.logs"
    rundir   : "#{projectRoot}/.supervisor"
    minfds   : 1024
    minprocs : 200

  KONFIG.supervisord.output_path = "#{projectRoot}/supervisord.conf"

  KONFIG.supervisord.unix_http_server =
    file : "#{KONFIG.supervisord.rundir}/supervisor.sock"


  #-------------------------------------------------------------------------#
  #---- SECTION: AUTO GENERATED CONFIGURATION FILES ------------------------#
  #---- DO NOT CHANGE ANYTHING BELOW. IT'S GENERATED FROM WHAT'S ABOVE  ----#
  #-------------------------------------------------------------------------#

  KONFIG.JSON = JSON.stringify KONFIG

  #---- SUPERVISOR CONFIG ----#

  generateRunFile = (KONFIG) ->

    killlist = ->
      str = "kill -KILL "
      for key, worker of KONFIG.workers
        unless isAllowed worker.group, KONFIG.ebEnvName
          continue

        str += "$#{key}pid "

      return str

    envvars = (options = {}) ->

      options.exclude ?= []
      options.exclude  = options.exclude.concat \
        Object.keys(process.env).filter (v) -> /^KONFIG_/.test v

      if options.print and options.exclude.length > 0
        console.log ">>> FOLLOWING ENVIRONMENT VARIABLES WILL BE USED: \n", options.exclude.join ', '

      env = """
      export GOPATH=#{projectRoot}/go
      export GOBIN=#{projectRoot}/go/bin
      """
      env += "export #{key}='#{val}'\n" for key,val of KONFIG.ENV when key not in options.exclude
      return env

    workerList = (separator=" ")->
      (key for key,val of KONFIG.workers).join separator

    workersRunList = ->
      workers = ""
      for name, worker of KONFIG.workers when worker.supervisord
        # some of the locations can be limited to some environments, while creating
        # nginx locations filter with this info
        unless isAllowed worker.group, KONFIG.ebEnvName
          continue

        {command} = worker.supervisord

        if typeof command is 'object'
          {run, watch} = command
          command = if options.runGoWatcher then watch else run

        workers += """

        function worker_daemon_#{name} {

          #------------- worker: #{name} -------------#
          #{command} &>#{projectRoot}/.logs/#{name}.log &
          #{name}pid=$!
          echo [#{name}] started with pid: $#{name}pid


        }

        function worker_#{name} {

          #------------- worker: #{name} -------------#
          #{command}

        }

        """
      return workers

    installScript = """
        cd #{projectRoot}
        git submodule update --init

        npm install --unsafe-perm

        echo '#---> BUILDING CLIENT <---#'
        make -C #{projectRoot}/client unit-tests

        echo '#---> BUILDING GO WORKERS (@farslan) <---#'
        #{projectRoot}/go/build.sh

        echo '#---> BUILDING SOCIALAPI (@cihangir) <---#'
        cd #{projectRoot}/go/src/socialapi
        make configure
        # make install
        cd #{projectRoot}
        cleanchatnotifications

        echo '#---> AUTHORIZING THIS COMPUTER WITH MATCHING KITE.KEY (@farslan) <---#'
        mkdir $HOME/.kite &>/dev/null
        echo copying #{KONFIG.newkites.keyFile} to $HOME/.kite/kite.key
        cp -f #{KONFIG.newkites.keyFile} $HOME/.kite/kite.key

        echo '#---> BUILDING BROKER-CLIENT @chris <---#'
        echo "building koding-broker-client."
        cd #{projectRoot}/node_modules_koding/koding-broker-client
        cake build
        cd #{projectRoot}


        echo
        echo
        echo 'ALL DONE. Enjoy! :)'
        echo
        echo
    """

    run = """
      #!/bin/bash

      # ------ THIS FILE IS AUTO-GENERATED ON EACH BUILD ----- #\n
      mkdir #{projectRoot}/.logs &>/dev/null

      SERVICES="mongo redis postgres rabbitmq"

      NGINX_CONF="#{projectRoot}/.default.nginx.conf"
      NGINX_PID="#{projectRoot}/.default.nginx.pid"

      #{envvars({ print: yes })}

      trap ctrl_c INT

      function ctrl_c () {
        echo "ctrl_c detected. killing all processes..."
        kill_all
      }

      function kill_all () {
        #{killlist()}

        echo "killing hung processes"
        # there is race condition, that killlist() can not kill all process
        sleep 3


        # both of them are  required
        ps aux | grep koding | grep -v cmd.coffee | grep -E 'node|go/bin' | awk '{ print $2 }' | xargs kill -9
        pkill -9 koding-
      }

      function nginxstop () {
        if [ -a $NGINX_PID ]; then
          echo "stopping nginx"
          nginx -c $NGINX_CONF -g "pid $NGINX_PID;" -s quit
        fi
      }

      function nginxrun () {
        nginxstop
        echo "starting nginx"
        nginx -c $NGINX_CONF -g "pid $NGINX_PID;"
      }

      function checkrunfile () {

        if [ "#{projectRoot}/run" -ot "#{projectRoot}/config/main.default.coffee" ]; then
            echo your run file is older than your config file. doing ./configure.
            sleep 1
            ./configure

            echo -e "\n\nPlease do ./run again\n"
            exit 1;
        fi

        if [ "#{projectRoot}/run" -ot "#{projectRoot}/configure" ]; then
            echo your run file is older than your configure file. doing ./configure.
            sleep 1
            ./configure

            echo -e "\n\nPlease do ./run again\n"
            exit 1;
        fi
      }

      function testendpoints () {

        EP=("dev.koding.com:8090/" "dev.koding.com:8090/xhr" "dev.koding.com:8090/subscribe/info" "dev.koding.com:8090/kloud/kite" "dev.koding.com:8090/kontrol/kite" "dev.koding.com:8090/sourcemaps")

        while [ 1==1 ];
        do
        for i in "${EP[@]}"
          do

             curl $i -s -f -o /dev/null || echo "DOWN $i" # | mail -s "Website is down" admin@thesite.com

          done
        sleep 1
        done
      }



      function chaosmonkey () {

        while [ 1==1 ]; do
          for i in mongo redis postgres
            do
              echo stopping $i
              docker stop $i
              echo starting $i
              docker start $i
              sleep 10
            done
        done

        echo now do "run services" again to make sure everything is back to normal..
      }

      function printconfig () {
        if [ "$2" == "" ]; then
          cat << EOF
          #{envvars(exclude:["KONFIG_JSON"])}EOF
        elif [ "$2" == "--json" ]; then

          echo '#{KONFIG.JSON}'

        else
          echo ""
        fi

      }

      function migrations () {
        # a temporary migration line (do we still need this?)
        env PGPASSWORD=#{postgres.password} psql -tA -h #{postgres.host} #{postgres.dbname} -U #{postgres.username} -c "ALTER TYPE \"api\".\"channel_type_constant_enum\" ADD VALUE IF NOT EXISTS 'collaboration';"
        env PGPASSWORD=#{postgres.password} psql -tA -h #{postgres.host} #{postgres.dbname} -U #{postgres.username} -c "ALTER TYPE \"api\".\"channel_participant_status_constant_enum\" ADD VALUE IF NOT EXISTS 'blocked';"
        env PGPASSWORD=#{postgres.password} psql -tA -h #{postgres.host} #{postgres.dbname} -U #{postgres.username} -c "ALTER TYPE \"api\".\"channel_type_constant_enum\" ADD VALUE IF NOT EXISTS 'linkedtopic';"
        env PGPASSWORD=#{postgres.password} psql -tA -h #{postgres.host} #{postgres.dbname} -U #{postgres.username} -c "ALTER TYPE \"api\".\"channel_type_constant_enum\" ADD VALUE IF NOT EXISTS 'bot';"
        env PGPASSWORD=#{postgres.password} psql -tA -h #{postgres.host} #{postgres.dbname} -U #{postgres.username} -c "ALTER TYPE \"api\".\"channel_message_type_constant_enum\" ADD VALUE IF NOT EXISTS 'bot';"
        env PGPASSWORD=#{postgres.password} psql -tA -h #{postgres.host} #{postgres.dbname} -U #{postgres.username} -c "ALTER TYPE \"api\".\"channel_message_type_constant_enum\" ADD VALUE IF NOT EXISTS 'system';"
        env PGPASSWORD=#{postgres.password} psql -tA -h #{postgres.host} #{postgres.dbname} -U #{postgres.username} -c "ALTER TYPE \"payment\".\"plan_title_enum\" ADD VALUE IF NOT EXISTS 'bootstrap';"
        env PGPASSWORD=#{postgres.password} psql -tA -h #{postgres.host} #{postgres.dbname} -U #{postgres.username} -c "ALTER TYPE \"payment\".\"plan_title_enum\" ADD VALUE IF NOT EXISTS 'startup';"
        env PGPASSWORD=#{postgres.password} psql -tA -h #{postgres.host} #{postgres.dbname} -U #{postgres.username} -c "ALTER TYPE \"payment\".\"plan_title_enum\" ADD VALUE IF NOT EXISTS 'enterprise';"
      }

      function run () {

        # Check if PG DB schema update required
        go run go/src/socialapi/tests/pg-update.go #{postgres.host} #{postgres.port}
        RESULT=$?

        if [ $RESULT -ne 0 ]; then
          exit 1
        fi

        # Update node modules
        if ! scripts/check-node_modules.sh; then
          npm install --silent
        fi

        # Check everything else
        check

        # Remove old watcher files (do we still need this?)
        rm -rf #{projectRoot}/go/bin/goldorf-main-*
        rm -rf #{projectRoot}/go/bin/watcher-*

        # Run Go builder
        #{projectRoot}/go/build.sh

        # Run Social Api builder
        make -C #{projectRoot}/go/src/socialapi configure

        # Do PG Migration if necessary
        migrate up

        # Create default workspaces
        node scripts/create-default-workspace

        # Sanitize email addresses
        node #{projectRoot}/scripts/sanitize-email

        # Run all the worker daemons in KONFIG.workers
        #{("worker_daemon_"+key+"\n" for key,val of KONFIG.workers when val.supervisord and key not in disabledWorkers).join(" ")}

        # Check backend option, if it's then bypass client build
        if [ "$1" == "backend" ] ; then

          echo
          echo '---------------------------------------------------------------'
          echo '>>> CLIENT BUILD DISABLED! DO "make -C client" MANUALLY <<<'
          echo '---------------------------------------------------------------'
          echo

        else
          make -C #{projectRoot}/client
        fi

        # Show the all logs of workers
        tail -fq ./.logs/*.log

      }

      #{workersRunList()}


      function printHelp (){

        echo "Usage: "
        echo ""
        echo "  run                       : to start koding"
        echo "  run backend               : to start only backend of koding"
        echo "  run killall               : to kill every process started by run script"
        echo "  run install               : to compile/install client and "
        echo "  run buildclient           : to see of specified worker logs only"
        echo "  run logs                  : to see all workers logs"
        echo "  run log [worker]          : to see of specified worker logs only"
        echo "  run buildservices         : to initialize and start services"
        echo "  run buildservices sandbox : to initialize and start services on sandbox"
        echo "  run resetdb               : to reset databases"
        echo "  run services              : to stop and restart services"
        echo "  run worker                : to list workers"
        echo "  run chaosmonkey           : to restart every service randomly to test resilience."
        echo "  run testendpoints         : to test every URL endpoint programmatically."
        echo "  run printconfig           : to print koding config environment variables (output in json via --json flag)"
        echo "  run worker [worker]       : to run a single worker"
        echo "  run supervisor [env]      : to show status of workers in that environment"
        echo "  run migrate [command]     : to apply/revert database changes (command: [create|up|down|version|reset|redo|to|goto])"
        echo "  run importusers           : to import koding user data"
        echo "  run nodeservertests       : to run tests for node.js web server"
        echo "  run socialworkertests     : to run tests for social worker"
        echo "  run nodetestfiles         : to run a single test or all test files in a directory"
        echo "  run sanitize-email        : to sanitize email"
        echo "  run help                  : to show this list"
        echo ""

      }

      function migrate () {
        migrations

        params=(create up down version reset redo to goto)
        param=$1

        case "${params[@]}" in  *"$param"*)
          ;;
        *)
          echo "Error: Command not found: $param"
          echo "Usage: run migrate COMMAND [arg]"
          echo ""
          echo "Commands:  "
          echo "  create [filename] : create new migration file in path"
          echo "  up                : apply all available migrations"
          echo "  down              : roll back all migrations"
          echo "  redo              : roll back the most recently applied migration, then run it again"
          echo "  reset             : run down and then up command"
          echo "  version           : show the current migration version"
          echo "  to   [n]          : (+n) apply the next n / (-n) roll back the previous n migrations"
          echo "  goto [n]          : go to specific migration"

          echo ""
          exit 1
        ;;
        esac

        if [ "$param" == "to" ]; then
          param="migrate"
        elif [ "$param" == "create" ] && [ -z "$2" ]; then
          echo "Please choose a migration file name. (ex. add_created_at_column_account)"
          echo "Usage: run migrate create [filename]"
          echo ""
          exit 1
        fi

        #{GOBIN}/migrate -url "postgres://#{postgres.host}:#{postgres.port}/#{postgres.dbname}?user=social_superuser&password=social_superuser" -path "#{projectRoot}/go/src/socialapi/db/sql/migrations" $param $2

        if [ "$param" == "create" ]; then
          echo "Please edit created script files and add them to your repository."
        fi

      }

      function check (){

        check_service_dependencies

        if [[ `uname` == 'Darwin' ]]; then
          if [ -z "$DOCKER_HOST" ]; then
            echo "You need to export DOCKER_HOST, run 'boot2docker up' and follow the instructions."
            exit 1
          fi
        fi

        mongo #{mongo} --eval "db.stats()" > /dev/null  # do a simple harmless command of some sort

        RESULT=$?   # returns 0 if mongo eval succeeds

        if [ $RESULT -ne 0 ]; then
            echo ""
            echo "Can't talk to mongodb at #{mongo}, is it not running? exiting."
            exit 1
        fi

        EXISTS=$(PGPASSWORD=kontrolapp201506 psql -tA -h #{boot2dockerbox} social -U kontrolapp201506 -c "Select 1 from pg_tables where tablename = 'key' AND schemaname = 'kite';")
        if [[ $EXISTS != '1' ]]; then
          echo ""
          echo "You don't have the new Kontrol Postgres. Please call ./run buildservices."
          exit 1
        fi

      }

      function check_psql () {
        command -v psql          >/dev/null 2>&1 || { echo >&2 "I require psql but it's not installed. (brew install postgresql)  Aborting."; exit 1; }
      }

      function check_service_dependencies () {
        echo "checking required services: nginx, docker, mongo, graphicsmagick..."
        command -v go            >/dev/null 2>&1 || { echo >&2 "I require go but it's not installed.  Aborting."; exit 1; }
        command -v docker        >/dev/null 2>&1 || { echo >&2 "I require docker but it's not installed.  Aborting."; exit 1; }
        command -v nginx         >/dev/null 2>&1 || { echo >&2 "I require nginx but it's not installed. (brew install nginx maybe?)  Aborting."; exit 1; }
        command -v mongorestore  >/dev/null 2>&1 || { echo >&2 "I require mongorestore but it's not installed.  Aborting."; exit 1; }
        command -v node          >/dev/null 2>&1 || { echo >&2 "I require node but it's not installed.  Aborting."; exit 1; }
        command -v npm           >/dev/null 2>&1 || { echo >&2 "I require npm but it's not installed.  Aborting."; exit 1; }
        command -v gulp          >/dev/null 2>&1 || { echo >&2 "I require gulp but it's not installed. (npm i gulp -g)  Aborting."; exit 1; }
        # command -v stylus      >/dev/null 2>&1 || { echo >&2 "I require stylus  but it's not installed. (npm i stylus -g)  Aborting."; exit 1; }
        command -v coffee        >/dev/null 2>&1 || { echo >&2 "I require coffee-script but it's not installed. (npm i coffee-script -g)  Aborting."; exit 1; }
        check_psql

        if [[ `uname` == 'Darwin' ]]; then
          brew info graphicsmagick >/dev/null 2>&1 || { echo >&2 "I require graphicsmagick but it's not installed.  Aborting."; exit 1; }
          command -v boot2docker   >/dev/null 2>&1 || { echo >&2 "I require boot2docker but it's not installed.  Aborting."; exit 1; }
        elif [[ `uname` == 'Linux' ]]; then
          command -v gm >/dev/null 2>&1 || { echo >&2 "I require graphicsmagick but it's not installed.  Aborting."; exit 1; }
        fi

        scripts/check-node-version.sh
        scripts/check-npm-version.sh
        scripts/check-gulp-version.sh
        scripts/check-go-version.sh
      }

      function build_services () {

        if [[ `uname` == 'Darwin' ]]; then
          boot2docker up
        fi

        echo "Stopping services: $SERVICES"
        docker stop $SERVICES

        echo "Removing services: $SERVICES"
        docker rm   $SERVICES

        # Build Mongo service
        cd #{projectRoot}/install/docker-mongo
        docker build -t koding/mongo .

        # Build rabbitMQ service
        cd #{projectRoot}/install/docker-rabbitmq
        docker build -t koding/rabbitmq .

        # Build postgres
        cd #{projectRoot}/go/src/socialapi/db/sql

        # Include this to dockerfile before we continute with building
        mkdir -p kontrol
        cp #{projectRoot}/go/src/github.com/koding/kite/kontrol/*.sql kontrol/
        sed -i -e 's/somerandompassword/kontrolapp201506/' kontrol/001-schema.sql
        sed -i -e 's/kontrolapplication/kontrolapp201506/' kontrol/001-schema.sql

        docker build -t koding/postgres .

        docker run -d -p 27017:27017              --name=mongo    koding/mongo --dbpath /data/db --smallfiles --nojournal
        docker run -d -p 5672:5672 -p 15672:15672 --name=rabbitmq koding/rabbitmq

        docker run -d -p 6379:6379                --name=redis    redis
        docker run -d -p 5432:5432                --name=postgres koding/postgres

        restoredefaultmongodump

        echo "#---> CLEARING ALGOLIA INDEXES: @chris <---#"
        cd #{projectRoot}
        ./scripts/clear-algolia-index.sh -i "accounts$KONFIG_SOCIALAPI_ALGOLIA_INDEXSUFFIX"
        ./scripts/clear-algolia-index.sh -i "topics$KONFIG_SOCIALAPI_ALGOLIA_INDEXSUFFIX"
        ./scripts/clear-algolia-index.sh -i "messages$KONFIG_SOCIALAPI_ALGOLIA_INDEXSUFFIX"

        migrate up
      }

      function services () {

        if [[ `uname` == 'Darwin' ]]; then
          boot2docker up
        fi
        EXISTS=$(docker inspect --format="{{ .State.Running }}" $SERVICES 2> /dev/null)
        if [ $? -eq 1 ]; then
          echo ""
          echo "Some of containers are missing, please do ./run buildservices"
          exit 1
        fi

        echo "Stopping services: $SERVICES"
        docker stop $SERVICES

        echo "Starting services: $SERVICES"
        docker start $SERVICES

        nginxrun
      }


      function importusers () {

        cd #{projectRoot}
        node #{projectRoot}/scripts/user-importer -c default

        migrateusers

      }

      function migrateusers () {

        echo '#---> UPDATING MONGO DB TO WORK WITH SOCIALAPI @cihangir <---#'
        mongo #{mongo} --eval='db.jAccounts.update({},{$unset:{socialApiId:0}},{multi:true}); db.jGroups.update({},{$unset:{socialApiChannelId:0}},{multi:true});'

        go run ./go/src/socialapi/workers/cmd/migrator/main.go -c #{socialapi.configFilePath}

        # Required step for guestuser
        mongo #{mongo} --eval='db.jAccounts.update({"profile.nickname":"guestuser"},{$set:{type:"unregistered", socialApiId:0}});'

      }

      function restoredefaultmongodump () {

        echo '#---> CREATING VANILLA KODING DB @gokmen <---#'

        mongo #{mongo} --eval "db.dropDatabase()"

        cd #{projectRoot}/install/docker-mongo
        if [[ -f #{projectRoot}/install/docker-mongo/custom-db-dump.tar.bz2 ]]; then
          tar jxvf #{projectRoot}/install/docker-mongo/custom-db-dump.tar.bz2
        else
          tar jxvf #{projectRoot}/install/docker-mongo/default-db-dump.tar.bz2
        fi
        mongorestore -h#{boot2dockerbox} -dkoding dump/koding
        rm -rf ./dump

        updatePermissions

      }

      function updatePermissions () {

        echo '#---> UPDATING MONGO DATABASE ACCORDING TO LATEST CHANGES IN CODE (UPDATE PERMISSIONS @gokmen) <---#'
        cd #{projectRoot}
        node #{projectRoot}/scripts/permission-updater -c default --reset

      }

      function updateusers () {

        cd #{projectRoot}
        node #{projectRoot}/scripts/user-updater

      }

      function create_default_workspace () {

        node #{projectRoot}/scripts/create-default-workspace

      }

      function cleanchatnotifications () {
        cd #{GOBIN}
        ./notification -c #{socialapi.configFilePath} -h
      }

      function sandbox_buildservices () {
        SANDBOX_SERVICES=54.165.122.100
        SANDBOX_WEB_1=54.165.177.88
        SANDBOX_WEB_2=54.84.179.170

        echo "cd /opt/koding; ./run buildservices" | ssh root@$SANDBOX_SERVICES @/bin/bash

        echo "sudo supervisorctl restart all"      | ssh ec2-user@$SANDBOX_WEB_1 /bin/bash
        echo "sudo supervisorctl restart all"      | ssh ec2-user@$SANDBOX_WEB_2 /bin/bash
      }

      if [[ "$1" == "killall" ]]; then

        kill_all

      elif [ "$1" == "install" ]; then
        check_service_dependencies
        #{installScript}

      elif [ "$1" == "printconfig" ]; then

        printconfig $@

      elif [[ "$1" == "log" || "$1" == "logs" ]]; then

        trap - INT
        trap

        if [ "$2" == "" ]; then
          tail -fq ./.logs/*.log
        else
          tail -fq ./.logs/$2.log
        fi

      elif [ "$1" == "cleanup" ]; then

        ./cleanup $@

      elif [ "$1" == "buildclient" ]; then

        make -C #{projectRoot}/client dist

      elif [ "$1" == "services" ]; then
        check_service_dependencies
        services

      elif [ "$1" == "updatepermissions" ]; then
        updatePermissions

      elif [ "$1" == "resetdb" ]; then

        if [ "$2" == "--yes" ]; then

          env PGPASSWORD=social_superuser psql -tA -h #{postgres.host} #{postgres.dbname} -U social_superuser -c "DELETE FROM \"api\".\"channel_participant\"; DELETE FROM \"api\".\"channel\";DELETE FROM \"api\".\"account\";"
          restoredefaultmongodump
          migrateusers

          exit 0

        fi

        read -p "This will reset current databases, all data will be lost! (y/N)" -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]
        then
            exit 1
        fi

        env PGPASSWORD=social_superuser psql -tA -h #{postgres.host} #{postgres.dbname} -U social_superuser -c "DELETE FROM \"api\".\"channel_participant\"; DELETE FROM \"api\".\"channel\";DELETE FROM \"api\".\"account\";"
        restoredefaultmongodump
        migrateusers

      elif [ "$1" == "buildservices" ]; then

        if [ "$2" == "sandbox" ]; then
          read -p "This will destroy sandbox databases (y/N)" -n 1 -r
          echo ""
          if [[ ! $REPLY =~ ^[Yy]$ ]]
          then
              exit 1
          fi

          sandbox_buildservices
          exit 0
        fi

        check_service_dependencies

        if [ "$2" != "force" ]; then
          read -p "This will destroy existing images, do you want to continue? (y/N)" -n 1 -r
          echo ""
          if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
          fi
        fi

        build_services
        importusers
        migrate up

      elif [ "$1" == "help" ]; then
        printHelp

      elif [ "$1" == "chaosmonkey" ]; then
        chaosmonkey

      elif [ "$1" == "testendpoints" ]; then
        testendpoints

      elif [ "$1" == "importusers" ]; then
        importusers

      elif [ "$1" == "updateusers" ]; then
        updateusers

      elif [ "$1" == "create_default_workspace" ]; then
        create_default_workspace

      elif [ "$1" == "cleanchatnotifications" ]; then
        cleanchatnotifications

      elif [ "$1" == "worker" ]; then

        if [ "$2" == "" ]; then
          echo Available workers:
          echo "-------------------"
          echo '#{workerList "\n"}'
        else
          trap - INT
          trap
          eval "worker_$2"
        fi

      elif [ "$1" == "supervisor" ]; then

        SUPERVISOR_ENV=$2
        if [ $SUPERVISOR_ENV == "" ]; then
          SUPERVISOR_ENV="production"
        fi

        go run scripts/supervisor_status.go $SUPERVISOR_ENV
        open supervisor.html

      elif [ "$1" == "migrate" ]; then
        check_psql

        if [ -z "$2" ]; then
          echo "Please choose a migrate command [create|up|down|version|reset|redo|to|goto]"
          echo ""
        else
          cd "#{GOPATH}/src/socialapi"
          make install-migrate
          migrate $2 $3
        fi

      elif [ "$1" == "backend" ] || [ "$#" == "0" ] ; then

        checkrunfile
        run $1

      elif [ "$1" == "vmwatchertests" ]; then
        go test koding/vmwatcher -test.v=true

      elif [ "$1" == "janitortests" ]; then
        cd go/src/koding/workers/janitor
        ./test.sh

      elif [ "$1" == "gatheringestortests" ]; then
        go test koding/workers/gatheringestor -test.v=true

      elif [ "$1" == "gomodeltests" ]; then
        go test koding/db/mongodb/modelhelper -test.v=true

      elif [ "$1" == "socialworkertests" ]; then
        #{projectRoot}/scripts/node-testing/mocha-runner "#{projectRoot}/workers/social"

      elif [ "$1" == "nodeservertests" ]; then
        #{projectRoot}/scripts/node-testing/mocha-runner "#{projectRoot}/servers/lib/server"

      # To run specific test directory or a single test file
      elif [ "$1" == "nodetestfiles" ]; then
        #{projectRoot}/scripts/node-testing/mocha-runner $2

      elif [ "$1" == "sanitize-email" ]; then
        node #{projectRoot}/scripts/sanitize-email

      elif [ "$1" == "migrations" ]; then
        migrations

      else
        echo "Unknown command: $1"
        printHelp

      fi
      # ------ THIS FILE IS AUTO-GENERATED BY ./configure ----- #\n
      """
    return run

  KONFIG.ENV            = (require "../deployment/envvar.coffee").create KONFIG
  KONFIG.supervisorConf = (require "../deployment/supervisord.coffee").create KONFIG
  KONFIG.nginxConf      = (require "../deployment/nginx.coffee").create KONFIG, environment
  KONFIG.runFile        = generateRunFile        KONFIG

  KONFIG.configCheckExempt = []

  return KONFIG

module.exports = Configuration


# -*- mode: coffee -*-
# vi: set ft=coffee nowrap :