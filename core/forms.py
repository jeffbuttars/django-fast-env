# encoding: utf-8

from django.contrib.auth.forms import AuthenticationForm
from django import forms
from django.utils.translation import ugettext_lazy as _
from django.forms.widgets import TextInput


"""
A bootstrapped version of the login form
"""

class BSAuthenticationForm(AuthenticationForm):
    username = forms.CharField(
        widget=TextInput(attrs={
            'placeholder': 'Username',
            'class': 'form-control',
            'title': 'Username',
        }),
        label=_("Username"),
        max_length=254,
    )

    password = forms.CharField(
        widget=forms.PasswordInput(
            attrs={'placeholder': 'Password',
                   'class': 'form-control',
                   'title': 'Password',
                   }),
        label=_("Password"),
    )
#BSAuthenticationForm

