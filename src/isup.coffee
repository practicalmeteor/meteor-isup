#log = new ObjectLogger("practicalmeteor:isup")
@isup = new Mongo.Collection("isup")

# Populate to collection
if not isup.findOne({})
  isup.insert({isup: "yes"})