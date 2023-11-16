// mainwindow.cpp
#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent)
{
    // Textbox
    lineEdit = new QLineEdit(this);
    lineEdit_2 = new QLineEdit(this);

    // Button
    sumButton = new QPushButton("Sum", this);
    clearButton = new QPushButton("Clear", this);

    // Result Label
    labelResult = new QLabel("Result: ", this);

    // Layout
    QHBoxLayout *layout = new QHBoxLayout;
    layout->addWidget(lineEdit);
    layout->addWidget(lineEdit_2);
    layout->addWidget(sumButton);
    layout->addWidget(clearButton);
    layout->addWidget(labelResult);


    QWidget *centralWidget = new QWidget(this);
    centralWidget->setLayout(layout);
    setCentralWidget(centralWidget);

    // Connect Signals and Slots
    connect(sumButton, SIGNAL(clicked()), this, SLOT(onSumButtonClicked()));
    connect(clearButton, SIGNAL(clicked()), this, SLOT(onClearButtonClicked()));
}

void MainWindow::onSumButtonClicked()
{
    double num1 = lineEdit->text().toDouble();
    double num2 = lineEdit_2->text().toDouble();

    // sum
    double sum = num1 + num2;

    // Display result
    labelResult->setText("Result: " + QString::number(sum));
}

void MainWindow::onClearButtonClicked()
{
    // Clear Line Edits and result Label
    lineEdit->clear();
    lineEdit_2->clear();
    labelResult->clear();
}
