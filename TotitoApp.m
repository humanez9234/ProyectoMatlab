classdef TotitoApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure        matlab.ui.Figure
        Buttons        % Matriz de botones
        Label          matlab.ui.control.Label
        ResetButton    matlab.ui.control.Button
        ScoreLabel     matlab.ui.control.Label
    end
    
    properties (Access = private)
        Tablero
        Jugador
        Score % [victorias jugador1, victorias jugador2, empates]
    end
    
    methods (Access = private)
        
        function initializeGame(app)
            app.Tablero = zeros(3,3);
            app.Jugador = 1;
            app.Label.Text = 'Turno: Jugador 1 (X)';
            for i = 1:3
                for j = 1:3
                    app.Buttons(i,j).Text = '';
                    app.Buttons(i,j).Enable = 'on';
                end
            end
        end
        
        function updateScoreLabel(app)
            app.ScoreLabel.Text = sprintf('Jugador 1 (X): %d | Jugador 2 (O): %d | Empates: %d', app.Score(1), app.Score(2), app.Score(3));
        end
        
        function checkWinner(app)
            t = app.Tablero;
            winner = 0;
            
            % Filas y columnas
            for i = 1:3
                if all(t(i,:) == app.Jugador)
                    winner = app.Jugador;
                end
                if all(t(:,i) == app.Jugador)
                    winner = app.Jugador;
                end
            end
            % Diagonales
            if all(diag(t) == app.Jugador)
                winner = app.Jugador;
            end
            if all(diag(flipud(t)) == app.Jugador)
                winner = app.Jugador;
            end
            
            if winner
                app.Label.Text = sprintf('¡Jugador %d gana!', winner);
                app.Score(winner) = app.Score(winner) + 1;
                updateScoreLabel(app);
                for i = 1:3
                    for j = 1:3
                        app.Buttons(i,j).Enable = 'off';
                    end
                end
            elseif all(t(:) ~= 0)
                app.Label.Text = '¡Empate!';
                app.Score(3) = app.Score(3) + 1;
                updateScoreLabel(app);
            else
                app.Jugador = 3 - app.Jugador; % alternar 1 ↔ 2
                if app.Jugador == 1
                    app.Label.Text = 'Turno: Jugador 1 (X)';
                else
                    app.Label.Text = 'Turno: Jugador 2 (O)';
                end
            end
        end
        
        function buttonPushed(app, row, col)
            if app.Tablero(row, col) == 0
                app.Tablero(row, col) = app.Jugador;
                if app.Jugador == 1
                    app.Buttons(row, col).Text = 'X';
                else
                    app.Buttons(row, col).Text = 'O';
                end
                checkWinner(app);
            end
        end
        
    end
    
    methods (Access = private)

        function createComponents(app)
            app.UIFigure = uifigure('Position', [100 100 300 450]);
            app.Label = uilabel(app.UIFigure, 'Position', [50 400 200 30], 'Text', 'Turno: Jugador 1 (X)', 'HorizontalAlignment', 'center');
            app.ScoreLabel = uilabel(app.UIFigure, 'Position', [25 370 250 20], 'Text', '', 'HorizontalAlignment', 'center');
            app.ResetButton = uibutton(app.UIFigure, 'Position', [100 330 100 30], 'Text', 'Reiniciar', 'ButtonPushedFcn', @(~,~)initializeGame(app));
            app.Buttons = gobjects(3,3);
            
            for i = 1:3
                for j = 1:3
                    x = 50 + (j-1)*70;
                    y = 220 - (i-1)*70;
                    app.Buttons(i,j) = uibutton(app.UIFigure, 'Position', [x y 60 60], 'FontSize', 24, 'ButtonPushedFcn', @(btn,~)buttonPushed(app, i, j));
                end
            end
        end
        
    end
    
    methods (Access = public)

        function app = TotitoApp
            createComponents(app);
            app.Score = [0, 0, 0]; % inicializar marcador a
            updateScoreLabel(app);
            initializeGame(app);
        end

    end
end
