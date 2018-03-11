Code.load_file("parent_child.exs")
Process.flag(:trap_exit, true)
spawn_link(MultipleProcesses, :child, [self(), &exit/1])

:timer.sleep(500)
MultipleProcesses.read_message()
