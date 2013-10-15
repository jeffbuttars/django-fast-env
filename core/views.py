from annoying.decorators import render_to
from core.forms import BSAuthenticationInlineForm


def default_data():
    return {
        'login_form': BSAuthenticationInlineForm,
            }
# default_data()


@render_to("core_index.djml")
def index(req):
    return default_data()
# index()

