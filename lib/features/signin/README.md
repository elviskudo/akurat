sso: https://sso.imerzone.com/login-sso

response_url: https://sso.imerzone.com/api/auth/login

email: mail@imerzone.com

password: P@ssw0rd

---

reponse_error:

```json
{
  "error":"Unauthorized"
}
```

response_success_schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "status": {
      "type": "string"
    },
    "user": {
      "type": "object",
      "properties": {
        "id": {
          "type": "integer"
        },
        "name": {
          "type": "string"
        },
        "email": {
          "type": "string"
        },
        "email_verified_at": {
          "type": "null"
        },
        "two_factor_confirmed_at": {
          "type": "null"
        },
        "current_team_id": {
          "type": "string"
        },
        "profile_photo_path": {
          "type": "null"
        },
        "created_at": {
          "type": "string"
        },
        "updated_at": {
          "type": "string"
        },
        "profile_photo_url": {
          "type": "string"
        }
      },
      "required": [
        "id",
        "name",
        "email",
        "email_verified_at",
        "two_factor_confirmed_at",
        "current_team_id",
        "profile_photo_path",
        "created_at",
        "updated_at",
        "profile_photo_url"
      ]
    },
    "authorization": {
      "type": "object",
      "properties": {
        "token": {
          "type": "string"
        },
        "type": {
          "type": "string"
        }
      },
      "required": [
        "token",
        "type"
      ]
    }
  },
  "required": [
    "status",
    "user",
    "authorization"
  ]
}
```
