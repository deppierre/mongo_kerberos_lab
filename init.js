db.getSiblingDB('$external').createUser(
    {
      user: "muser@KRB5.MONGODB-FIELD.COM",
      roles: [ { role: "root", db: "admin" } ]
    }
 )

db.getSiblingDB('admin').shutdownServer()