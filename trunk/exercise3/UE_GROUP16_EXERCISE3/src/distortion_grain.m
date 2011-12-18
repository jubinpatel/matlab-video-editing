% DISTORTION_GRAIN(VIDEO) adds film grain to an existing frame in
% VIDEO.FRAME(1).FILTERED.
%  
%   VIDEO:  a structure containing an array of frames where frame(1)
%   contains the most current frame. 
%
%   VIDEO = DISTORTION_GRAIN(VIDEO, PARAM1, ...) returns the original video structure
%   with the updated current video.frame(1).filtered.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   IMPLEMENTATION:
%       Filmk�rnung wurde durch den Matlab Befehl "imnoise" erzeugt.
%       Um den gew�nschten Effekt zu erzielen wurde als Typ des Rauschens 'speckle' gew�hlt.
%       Dieser Typ erzeugt ein multiplikatives Rauschen mit einer gewissen
%       Varianz um den Mittelwert 0.
%       Der Parameter "variance" stellt die Varianz dar, wobei man keinen
%       Mittelwert �bergeben muss, da dieser immer als 0 genommen wird.
%       Ein variance-Wert von 0.005 erzeugt ein glaubw�rdiges Ausgabebild.
%       Das Rauschen wird auf jeden der 3 Farbkan�le angewandt und erzeugt
%       dadurch ein buntes Rauschen im Ausgabebild.
%   
%   PHYSICAL BACKGROUND:
%     How is it caused?
%       "Filmkorn nennt man in der Fotografie die kleinsten Strukturen des
%       entwickelten Films, die erst bei starker Vergr��erung gut sichtbar
%       werden. Fotochemisch handelt es sich dabei um Zusammenballungen von
%       feinst verteilten Silberpartikeln, die f�r die Zerrissenheit
%       gleichm��ig geschw�rzter Fl�chen verantwortlich sind.
%
%     Which movies are effected by these distortions?
%       Alle Filme sind davon betroffen, da allen analogen Filmen ein
%       photochemisches Material zu Grunde liegt. Allen digitalen Filmen
%       liegt ein Bildsensor zu Grunde welche ebenfalls eine
%       Rausch-charakteristik aufweist.
%
%     Can the distortion be avoided? If so, how?
%       "Die Fein- oder Grobk�rnigkeit ist sehr vom Filmtyp, aber auch von
%       den Entwicklungsbedingungen abh�ngig. Filme mit niedriger
%       Lichtempfindlichkeit, also mit niedrigen ISO-Werten, sind in der
%       Regel sehr viel feink�rniger als stark lichtempfindliche Filme mit
%       hohen ISO-Werten."
%       Weiters gilt zu beachten, dass "moderne Filme mit ISO 400 k�nnen
%       durchaus weniger st�rendes Korn aufweisen als mittelempfindliche
%       Filme (ISO 50 bis ISO 100) aus den 1970er Jahren."
%       Quelle: http://de.wikipedia.org/wiki/Filmkorn
%       In der heutigen digitalfotografie findet "nur" noch ein Rauschen
%       des digitalen Bildsensors statt, welches aber stetig besser
%       (geringer) ausf�llt und au�erdem durch digitale
%       Rauschunterdr�ckungsalgorithmen noch verbessert werden kann.
%
function video = distortion_grain(video, variance)

    if(video.frame(1).frame_nr == -1)
        return
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Apply imnoise filter on the whole image 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % apply noise to RED Channel
    video.frame(1).filtered(:,:,1) = imnoise(video.frame(1).filtered(:,:,1), 'speckle', variance);
    % apply noise to GREEN Channel
    video.frame(1).filtered(:,:,2) = imnoise(video.frame(1).filtered(:,:,2), 'speckle', variance);
    % apply noise to BLUE Channel
    video.frame(1).filtered(:,:,3) = imnoise(video.frame(1).filtered(:,:,3), 'speckle', variance);
    
    