% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125/8;        % grid size (horizontal)
dy = 0.0125/8;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 

% First consider the fundamental TE mode:

count = 1; 

for rw = 0.325:0.0675:1
    
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 
    
    [Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');

    fprintf(1,'neff = %.6f\n',n);

    figure(count);
    subplot(121);
    contourmode(x,y,Hx);
    title('Hx (TE mode)'); xlabel('x'); ylabel('y');
    for v = edges, line(v{:}); end

    subplot(122);
    contourmode(x,y,Hy);
    title('Hy (TE mode)'); xlabel('x'); ylabel('y');
    for v = edges, line(v{:}); end

    count = count +1; 

end

%With a Large width, the field remains within the waveguide fairly well and
%as the width decreases, the field begins to seap out of the waveguide
%until it is no longer contained and ouside of the wave guide. 

%With reduced mesh by 8x, the wave is better maintained within the the
%waveguide as the width decreases. 
