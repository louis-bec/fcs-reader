// Load all the backbone js file within this directory and all subdirectories.
// Channel files must be named *.coffee.

require('./fcs_reader')

const raffler_models = require.context('./models', true, /\.coffee$/)
raffler_models.keys().forEach(raffler_models)

const raffler_collections= require.context('./collections', true, /\.coffee$/)
raffler_collections.keys().forEach(raffler_collections)

const raffler_routers= require.context('./routers', true, /\.coffee$/)
raffler_routers.keys().forEach(raffler_routers)

const raffler_views = require.context('./views', true, /\.coffee$/)
raffler_views.keys().forEach(raffler_views)
