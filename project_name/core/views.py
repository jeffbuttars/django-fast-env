from django.views.generic.base import View
from django.utils.decorators import method_decorator
from annoying.decorators import render_to
from core.forms import BaseAuthenticationForm


class CoreView(View):

    """Docstring for CoreView """

    def base_data(self):
        """todo: Docstring for base_data
        :return:
        :rtype:
        """

        return {
            'login_form': BaseAuthenticationForm,
        }.copy()
    #base_data()

    def get(self, req, data={}):
        """todo: Docstring for get

        :param req: arg description
        :type req: type description
        :return:
        :rtype:
        """

        d = self.base_data()
        if data:
            d.update(data)

        return d
    # get()
# CoreView


class Index(CoreView):

    @method_decorator(render_to("core_index.html"))
    def get(self, req):
        """todo: Docstring for get

        :param req: arg description
        :type req: type description
        :return:
        :rtype:
        """
        return super(Index, self).get(req)
    #get()
#Index
