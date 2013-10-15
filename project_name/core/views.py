from annoying.decorators import render_to
from core.forms import BSAuthenticationForm


def default_data():
    return {
        'login_form': BSAuthenticationForm,
            }
# default_data()


@render_to("core_index.html")
def index(req):
    return default_data()
# index()
