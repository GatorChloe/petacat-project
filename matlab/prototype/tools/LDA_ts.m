% LDA test script
clear all; clc;

n = 1000;

d_0 = [ 1*randn(n,1)+0   2*randn(n,1)+2.5 ];
d_1 = [ 2*randn(n,1)+2.5   1*randn(n,1)+0 ];

data   = [d_0; d_1];
labels = [false(n,1); true(n,1)];
%[~,data] = princomp(data);

[W, d_vars, threshold] =  LDA( data, labels );



% view data

    figure
    subplot2(3,3,1,1,2,3);


    % figure
    % subplot(1,4,1)
    hold on
    plot(data(labels,1),data(labels,2),'.b');
    plot(data(~labels,1),data(~labels,2),'.r');
    hold off
    title('scatter');
    legend('class 0','class 1');
    xlabel('feature 1');
    ylabel('feature 2');
    

    
% view feature 1

    subplot2(3,3,3,1)
    
    % subplot(1,4,2)
    hist( data(:,1), fix(sqrt(n)) );
    % histn( data(:,1), labels );
    % title('feature 1');
    xlabel('feature 1');
    
    
% view feature 2

    subplot2(3,3,3,2)

    % subplot(1,4,3)
    hist( data(:,2), fix(sqrt(n)) );
    % histn( data(:,2), labels );
    % title('feature 2');
    xlabel('feature 2');
    

    
% view dvar
    
    subplot2(3,3,3,3);

    % subplot(1,4,4)
    hist( d_vars, fix(sqrt(n)) );
    % histn( d_vars, labels );
    % title('LDA decision variable');
    xlabel('LDA decision variable');
    
    
    
    
    
    
[AUROC_1,   TPR_1,   FPR_1]   = ROC( data(:,1), labels );
[AUROC_2,   TPR_2,   FPR_2]   = ROC( data(:,2), labels );
[AUROC_lda, TPR_lda, FPR_lda] = ROC( d_vars,    labels );

figure
hold on

plot(FPR_1,TPR_1,'green')
plot(FPR_2,TPR_2,'red')
plot(FPR_lda,TPR_lda,'blue') 
plot(linspace(0,1,2),linspace(0,1,2),'--','Color',[.5 .5 .5]);

xlabel('False positive rate');
ylabel('True positive rate');
title(['ROC curves'])
legend( ...
    ['Feature 1, AUROC: ' num2str(AUROC_1)], ...
    ['Feature 2, AUROC: ' num2str(AUROC_2)], ...
    ['LDA variable, AUROC: ' num2str(AUROC_lda)], ...
    ['Guessing, AUROC: ' num2str(.5)], ...
    'location','southeast' );

    
    
    
    
    
    
    
    
    


