from django.conf.urls import patterns, url
#from django.conf.urls import include

from core.forms import BSAuthenticationForm
import views

urlpatterns = patterns(
    '',
    url(r'^login/$',
        'django.contrib.auth.views.login',
        {'template_name': 'core_login.djml',
         "authentication_form": BSAuthenticationForm}),
    url(r'^logout/$',
        'django.contrib.auth.views.logout',
        {'next_page': '/'}),
    url(r'^$', views.index),
)
