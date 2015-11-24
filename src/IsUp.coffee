log = new ObjectLogger("practical.isup.IsUp")
@IsUp = new Mongo.Collection("isup")

# Populate
if not IsUp.findOne({})
  IsUp.insert({status: "yes"})