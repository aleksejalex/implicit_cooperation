%% Plot actions of both agents in time (script)
figure;
plot(data_1.a_to_t (1:end), '*')
hold on
plot(data_2.a_to_t (1:end), 'o')
xlabel("\v{c}as", 'Interpreter', 'latex')
ylabel("akce agenta", 'Interpreter', 'latex')
legend(["agent 1", "agent 2"], 'Interpreter', 'latex')
grid on
hold off