from django.views.generic.base import View
from django.utils.decorators import method_decorator
from annoying.decorators import render_to
from core.forms import BSAuthenticationForm


class CoreView(View):

    """Docstring for CoreView """

    def get(self, req):
        """todo: Docstring for get

        :param req: arg description
        :type req: type description
        :return:
        :rtype:
        """

        return {
            'login_form': BSAuthenticationForm,
        }
    # get()
# CoreView


class index(CoreView):

    @method_decorator(render_to("core_index.html"))
    def get(self, req):
        """todo: Docstring for get

        :param req: arg description
        :type req: type description
        :return:
        :rtype:
        """
        return super(index, self).get(req)
    #get()
#index
