classdef Assignment4final < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        AssignmentSubmittedbyKanishkverseLabel  matlab.ui.control.Label
        EditField              matlab.ui.control.EditField
        SigmaEditField         matlab.ui.control.NumericEditField
        SigmaEditFieldLabel    matlab.ui.control.Label
        ResetButton            matlab.ui.control.Button
        HsizeSlider            matlab.ui.control.Slider
        HsizeSliderLabel       matlab.ui.control.Label
        LoadImageButton        matlab.ui.control.Button
        SelectFilterKnob       matlab.ui.control.DiscreteKnob
        SelectFilterKnobLabel  matlab.ui.control.Label
        UIAxes_2               matlab.ui.control.UIAxes
        UIAxes                 matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        load % Description
        conv % Description
        Filter % Description
        filtered % Description
        hsize % Description
        sigma % Description
        logval % Description
    end
    
    methods (Access = private)
        
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: LoadImageButton
        function open(app, event)
            [file, path] = uigetfile('*.*');
            if isequal(file,0)
               figure(app.UIFigure);
               return;
            end
            figure(app.UIFigure);
            app.load = imread(fullfile(path, file));
            imshow(app.load,'parent',app.UIAxes);
        end

        % Value changed function: SelectFilterKnob
        function knob(app, event)
            value = app.SelectFilterKnob.Value;


            if strcmp(value,'No filter')
                figure(app.UIFigure);
                app.conv = (app.load);
                imshow(app.conv,'parent',app.UIAxes_2);
                app.SigmaEditField.Visible = 'off';      
                    app.SigmaEditFieldLabel.Visible = 'off';
                app.HsizeSlider.Visible = 'off';
                app.HsizeSliderLabel.Visible = 'off';
                app.EditField.Visible = 'off';
                


            elseif strcmp(value,'Average')
                figure(app.UIFigure);
                app.conv = (app.load);
                %a = Hsize(app);
                app.hsize = round(app.HsizeSlider.Value);
                app.Filter = fspecial('average',double(app.hsize));
                app.filtered = imfilter(app.conv,app.Filter);
                %app.Filter = rgb2gray(app.conv);
                imshow(app.filtered,'parent',app.UIAxes_2);
                app.SigmaEditField.Visible = 'off';      
                    app.SigmaEditFieldLabel.Visible = 'off';
                app.HsizeSlider.Visible = 'on';
                app.HsizeSliderLabel.Visible = 'on';
                app.EditField.Visible = 'on';
            elseif strcmp(value,'Gaussian ')
                   figure(app.UIFigure);
                   app.conv = (app.load);
                   app.hsize = round(app.EditField.Value);
                   app.sigma = round(app.SigmaEditField.Value);
                   app.Filter = fspecial('gaussian',double(app.hsize),double(app.sigma));
                   app.filtered = imfilter(app.conv,app.Filter);
                   imshow(app.filtered,'parent',app.UIAxes_2);
                   app.SigmaEditField.Visible = 'on';      
                    app.SigmaEditFieldLabel.Visible = 'on';
                app.HsizeSlider.Visible = 'on';
                app.HsizeSliderLabel.Visible = 'on';
                app.EditField.Visible = 'on';
                   
            elseif strcmp(value,' (LoG) ')
                   figure(app.UIFigure);
                   I = im2gray(app.load);
                   
                   app.Filter =  fspecial('log',double(round(app.HsizeSlider.Value)),double(app.SigmaEditField.Value));
                   app.filtered = imfilter(I,app.Filter);
                   imshow(app.filtered,'parent',app.UIAxes_2);
                   app.SigmaEditField.Visible = 'on';      
                    app.SigmaEditFieldLabel.Visible = 'on';
                app.HsizeSlider.Visible = 'on';
                app.HsizeSliderLabel.Visible = 'on';
                app.EditField.Visible = 'on';

            elseif strcmp(value,'Prewitt')
                   figure(app.UIFigure);
                   I = im2gray(app.load);
                 
                   app.Filter =  fspecial('prewitt');
                   app.filtered = imfilter(I,app.Filter);
                   imshow(app.filtered,'parent',app.UIAxes_2);
                   app.SigmaEditField.Visible = 'off';      
                    app.SigmaEditFieldLabel.Visible = 'off';
                app.HsizeSlider.Visible = 'off';
                app.HsizeSliderLabel.Visible = 'off';
                app.EditField.Visible = 'off';
            elseif strcmp(value,'Sobel ')
                   figure(app.UIFigure);
                   I = im2gray(app.load);
                 
                   app.Filter =  fspecial('sobel');
                   app.filtered = imfilter(I,app.Filter);
                   imshow(app.filtered,'parent',app.UIAxes_2);
                   app.SigmaEditField.Visible = 'off';
                    app.SigmaEditFieldLabel.Visible = 'off';
                app.HsizeSlider.Visible = 'off';
                app.HsizeSliderLabel.Visible = 'off';
                app.EditField.Visible = 'off';
            elseif strcmp(value,'Unsharp')
                   figure(app.UIFigure);
                   I = im2gray(app.load);
                 
                   app.Filter =  fspecial('unsharp');
                   app.filtered = imfilter(I,app.Filter);
                   imshow(app.filtered,'parent',app.UIAxes_2);
                   app.SigmaEditField.Visible = 'off';      
                    app.SigmaEditFieldLabel.Visible = 'off';
                app.HsizeSlider.Visible = 'off';
                app.HsizeSliderLabel.Visible = 'off';
                app.EditField.Visible = 'off';

            end
        end

        % Value changed function: SigmaEditField
        function SigmaEditFieldValueChanged(app, event)
            value = app.SigmaEditField.Value;
            app.SigmaEditField.Value = value;
          
        end

        % Callback function: HsizeSlider, HsizeSlider
        function HsizeSliderValueChanging(app, event)
                 changingValue = event.Value;
                 app.EditField.Value = num2str(round(changingValue));            
        end

        % Button pushed function: ResetButton
        function reset(app, event)
            app.UIAxes_2.Visible = 'off';
            
            
            app.SelectFilterKnob.Value = 'No filter';
            figure(app.UIFigure);
                app.conv = (app.load);
                imshow(app.conv,'parent',app.UIAxes_2);
                app.EditField.Value ="1";
               
                app.HsizeSlider.Value = 1;
                
            
           
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.8 0.8706 0.902];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Input Original Image')
            app.UIAxes.XTick = [];
            app.UIAxes.XTickLabel = '';
            app.UIAxes.YTick = [];
            app.UIAxes.TickDir = 'none';
            app.UIAxes.Visible = 'off';
            app.UIAxes.Position = [14 149 300 185];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.UIFigure);
            title(app.UIAxes_2, 'Output Filtered Image')
            app.UIAxes_2.XTick = [];
            app.UIAxes_2.XTickLabel = '';
            app.UIAxes_2.YTick = [];
            app.UIAxes_2.TickDir = 'none';
            app.UIAxes_2.Visible = 'off';
            app.UIAxes_2.Position = [336 149 300 185];

            % Create SelectFilterKnobLabel
            app.SelectFilterKnobLabel = uilabel(app.UIFigure);
            app.SelectFilterKnobLabel.HorizontalAlignment = 'center';
            app.SelectFilterKnobLabel.FontColor = [0.149 0.149 0.149];
            app.SelectFilterKnobLabel.Position = [268 327 69 22];
            app.SelectFilterKnobLabel.Text = 'Select Filter';

            % Create SelectFilterKnob
            app.SelectFilterKnob = uiknob(app.UIFigure, 'discrete');
            app.SelectFilterKnob.Items = {'No filter', 'Average', 'Gaussian ', ' (LoG) ', 'Prewitt', 'Sobel ', 'Unsharp'};
            app.SelectFilterKnob.ValueChangedFcn = createCallbackFcn(app, @knob, true);
            app.SelectFilterKnob.Tooltip = {'Select the Filters you want to apply on image'};
            app.SelectFilterKnob.FontWeight = 'bold';
            app.SelectFilterKnob.FontAngle = 'italic';
            app.SelectFilterKnob.FontColor = [0.149 0.149 0.149];
            app.SelectFilterKnob.Position = [265 369 76 76];
            app.SelectFilterKnob.Value = 'No filter';

            % Create LoadImageButton
            app.LoadImageButton = uibutton(app.UIFigure, 'push');
            app.LoadImageButton.ButtonPushedFcn = createCallbackFcn(app, @open, true);
            app.LoadImageButton.BackgroundColor = [0.502 0.502 0.502];
            app.LoadImageButton.FontWeight = 'bold';
            app.LoadImageButton.FontColor = [1 1 1];
            app.LoadImageButton.Tooltip = {'Click this button to load the image'};
            app.LoadImageButton.Position = [45 394 100 23];
            app.LoadImageButton.Text = 'Load Image';

            % Create HsizeSliderLabel
            app.HsizeSliderLabel = uilabel(app.UIFigure);
            app.HsizeSliderLabel.HorizontalAlignment = 'right';
            app.HsizeSliderLabel.Position = [539 411 35 22];
            app.HsizeSliderLabel.Text = 'Hsize';

            % Create HsizeSlider
            app.HsizeSlider = uislider(app.UIFigure);
            app.HsizeSlider.Limits = [1 100];
            app.HsizeSlider.ValueChangedFcn = createCallbackFcn(app, @HsizeSliderValueChanging, true);
            app.HsizeSlider.ValueChangingFcn = createCallbackFcn(app, @HsizeSliderValueChanging, true);
            app.HsizeSlider.Position = [454 399 150 3];
            app.HsizeSlider.Value = 1;

            % Create ResetButton
            app.ResetButton = uibutton(app.UIFigure, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @reset, true);
            app.ResetButton.BackgroundColor = [0.902 0.902 0.902];
            app.ResetButton.FontWeight = 'bold';
            app.ResetButton.FontColor = [0.6353 0.0784 0.1843];
            app.ResetButton.Tooltip = {'Reset the output image result'};
            app.ResetButton.Position = [236 76 133 23];
            app.ResetButton.Text = 'Reset';

            % Create SigmaEditFieldLabel
            app.SigmaEditFieldLabel = uilabel(app.UIFigure);
            app.SigmaEditFieldLabel.HorizontalAlignment = 'right';
            app.SigmaEditFieldLabel.FontWeight = 'bold';
            app.SigmaEditFieldLabel.FontAngle = 'italic';
            app.SigmaEditFieldLabel.Position = [422 444 41 22];
            app.SigmaEditFieldLabel.Text = 'Sigma';

            % Create SigmaEditField
            app.SigmaEditField = uieditfield(app.UIFigure, 'numeric');
            app.SigmaEditField.Limits = [0.5 100];
            app.SigmaEditField.ValueChangedFcn = createCallbackFcn(app, @SigmaEditFieldValueChanged, true);
            app.SigmaEditField.FontWeight = 'bold';
            app.SigmaEditField.FontAngle = 'italic';
            app.SigmaEditField.Position = [478 444 100 22];
            app.SigmaEditField.Value = 0.5;

            % Create EditField
            app.EditField = uieditfield(app.UIFigure, 'text');
            app.EditField.Position = [478 411 60 22];

            % Create AssignmentSubmittedbyKanishkverseLabel
            app.AssignmentSubmittedbyKanishkverseLabel = uilabel(app.UIFigure);
            app.AssignmentSubmittedbyKanishkverseLabel.HorizontalAlignment = 'center';
            app.AssignmentSubmittedbyKanishkverseLabel.FontWeight = 'bold';
            app.AssignmentSubmittedbyKanishkverseLabel.Position = [201 12 204 54];
            app.AssignmentSubmittedbyKanishkverseLabel.Text = {'Project Submitted '; 'by'; ' Kanishkverse'};

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Assignment4final

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
