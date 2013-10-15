from django.contrib.auth.models import AbstractUser
from django.db import models


class UserAccount(AbstractUser):
    pass
    # account = models.ForeignKey('Account', blank=True, null=True)

    # class Meta():
    #     permissions = (
    #         ('api_read_user', 'Can see User information'),
    #     )
    # #Meta
#UserAccount
