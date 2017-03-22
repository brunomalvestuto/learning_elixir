Code.load_file("parent_child.exs")

Process.flag(:trap_exit, true)
spawn_link(MultipleProcesses, :child, [self(), &raise/1])
:timer.sleep(1000)
MultipleProcesses.read_message()

