[![Build Status](https://travis-ci.org/practicalmeteor/meteor-isup.svg)](https://travis-ci.org/practicalmeteor/meteor-isup)
#practicalmeteor:isup

## practicalmeteor:isup

Adds a /isup route to verify your app is up and can connect to mongodb.

If successful, returns 'yes' as plain text in the body.

For use with website monitoring tools, such as [pingdom](https://www.pingdom.com/).

## Implementation

This package creates an isup collection with a single document in it:

```
{
  "isup": "yes"
}
```

When called, looks up the document in mongodb and:

- If found, returns a 200 HTTP status code with the value of the isup field as plain text in the body.

- If not found, returns a 404 HTTP status code.

- If it can't connect to mongodb, returns a 500 HTTP status code (internal server error).

## License

[MIT](https://github.com/practicalmeteor/meteor-isup/blob/master/LICENSE.txt)
