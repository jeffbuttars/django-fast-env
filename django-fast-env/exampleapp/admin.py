from django.contrib import admin
from django.conf import settings

from exampleapp.models import ExampleModel

class ExampleModelAdmin(admin.ModelAdmin):

	class Media():
		js = (
			"%sgrappelli/tinymce/jscripts/tiny_mce/tiny_mce.js" % settings.STATIC_URL,
			"%sgrappelli/tinymce_setup/tinymce_setup.js" % settings.STATIC_URL,
		)
	#Media
#ExampleModelAdmin
admin.site.register(ExampleModel, ExampleModelAdmin)
