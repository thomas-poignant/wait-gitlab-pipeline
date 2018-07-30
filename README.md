# Wait gitlab pipeline

A small script to wait until the gitlab pipeline is done.
It use gitlab API v4.

# How to use it

Before using this script please edit the variable **GITLAB_URL**.

```sh
$ wait-gitlab-pipeline ${gitlab-project-id} ${gitlab-private-token}
```

* **gitlab-project-id** : id of your gitlab projet [(How to find my project id)](https://stackoverflow.com/questions/39559689/where-do-i-find-the-project-id-for-the-gitlab-api)
* **gitlab-private-token** : gitlab personal access_token [(Personal access tokens)](https://docs.gitlab.com/ce/user/profile/personal_access_tokens.html)
