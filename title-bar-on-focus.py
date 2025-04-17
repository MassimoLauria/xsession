import sys


try:
    from i3ipc import Connection, Event
except ImportError:
    print(sys.args[0], "Install i3ipc")
    sys.exit(-1)

i3 = Connection()

prev_focused     = i3.get_tree().find_focused()
prev_workspace   = i3.get_tree().find_focused().workspace().num


def on_window_focus(self, e):
    global prev_focused
    focused = e.container
    if prev_focused.id != focused.id:
        prev_focused.command("border none")
        focused.command("border normal")
    prev_focused = focused

i3.on(Event.WINDOW_FOCUS, on_window_focus)

i3.main()
