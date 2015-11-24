log = new ObjectLogger("practical.isup.IsUp")
@IsUp = new Mongo.Collection("isup")

# Populate to collection
if not IsUp.findOne({})
  IsUp.insert({status: "yes"})