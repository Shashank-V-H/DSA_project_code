#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
struct sll
{
    char name[20];
    int score;
    struct sll *next;
};
typedef struct sll node;
node *g1 = NULL;
node *g2 = NULL;
node *g3 = NULL;
node *getnode()
{
    node *new1;
    char c;
    new1 = (node *)malloc(sizeof(node));
    new1->score = 0;
    printf("enter the name\n");
    scanf("%s%*c", new1->name);
    new1->next = NULL;
    return (new1);
}

void sort(node *g)
{
    node *current, *next_node;
    int temp_score;
    char temp_name[20];
    for (current = g; current != NULL; current = current->next)
    {
        for (next_node = current->next; next_node != NULL; next_node = next_node->next)
        {
            if (next_node->score > current->score)
            {
                temp_score = current->score;
                current->score = next_node->score;
                next_node->score = temp_score;
                strcpy(temp_name, current->name);
                strcpy(current->name, next_node->name);
                strcpy(next_node->name, temp_name);
            }
        }
    }
}

void display(node *g)
{
    system("cls");
    system("color B0");
    node *temp = g;
    int i=1;
    while (temp != NULL)
    {
        if(i==1){
            printf("HIGH SCORE\n");
            printf("--------------------------------\n");
            printf("%s\t\t%d\n", temp->name, temp->score);
            printf("--------------------------------\n");
            temp = temp->next;
            i++;
        }
        else{
        printf("%s\t%d\n", temp->name, temp->score);
        temp = temp->next;
        }
    }
    system("pause");
}
void guess_number()
{
    system("cls");
    system("color F1");
    node *new1;
    int a, b, n = 0;
    new1 = getnode();
    int x = 1;
    while (x != 0)
    {
        printf("guess the random number between 1-3:");
        scanf("%d%*c", &b);
        a = (rand() % 3) + 1;
        if (a == b)
        {
            n++;
        }
        else
            n--;
        printf("\nyour current score is %d", n);
        printf("\nenter\n(ANY NUMBER) to REPLAY\n<0> to EXIT this game\nenter:");
        scanf("%d", &x);
    }
    printf("RESULT\n");
    new1->score = n;
    if (g1 == NULL)
    {
        g1 = new1;
    }
    else
    {
        new1->next = g1;
        g1 = new1;
    }
    sort(g1);
    display(g1);
}
void cowsandbulls()
{
    system("cls");
    system("color 27");
    node *new1;
    new1 = getnode();
    const char arr2[40][40] = {"cat", "dog", "ant","bat","hat","pot","pet"}; // here 10 words need to be added
    int x;
    char a[20];
    x = rand() % 7; 
    strcpy(a, arr2[x]);
    char b[20];
    int cow = 0, bull = 0, quit;
    int pt = 0;
    while (1)
    {
        printf("\nenter 3 character word: >>");
        scanf("%s", b);
        bull = 0;
        cow = 0;

        for (int i = 0; a[i] != '\0'; i++)
        {
            for (int j = 0; b[j] != '\0'; j++)
            {
                if (a[i] == b[j])
                {
                    if (i == j)
                        bull++;
                    else
                        cow++;
                }
            }
        }
        if (bull == 3)
        {
            printf("the answer is correct\n");
            pt++;
        }
        else
            printf("bull=%d\ncow=%d", bull, cow);
        printf("\nyour current score is %d:",pt);
        printf("\nenter\n<0> to QUIT\n<1> to REPLAY\nENTER:");
        scanf("%d", &quit);
        if (quit == 1)
            continue;
        else if (quit == 0){
            printf("\nthe correct answer is <<<<---(%s)--->>>>:",a);
            break;
        }
    }
    system("pause");
    new1->score = pt;
    if (g2 == NULL)
    {
        g2 = new1;
    }
    else
    {
        new1->next = g2;
        g2 = new1;
    }
    sort(g2);
    display(g2);
}
void rokpapciss()
{
    system("cls");
    system("color 02");
    int ch, res = 0, n, ct = 0;
    node *new1;
    new1 = getnode();
    printf("Welcome to rock paper sissors\n");
while (ct <= 5)
{
    ct++;
    int a = rand() % 3;

    printf("press <1> to play the game:");
    scanf("%d", &n);
    if (n == 1)
    {

        printf("\nEnter your choice [0.rock], [1.paper], [2.sissors]\n");
        printf("enter your choice:");
        scanf("%d", &ch);
        if (a == 0 && ch == 0)
        {
            printf("draw\n");
        }

        else if (a == 0 && ch == 1)
        {
            printf("you won\n");
            res++;
        }
        else if (a == 0 && ch == 2)
        {
            printf("you lost\n");
        }
        else if (a == 1 && ch == 0)
        {
            printf("you lost\n");
        }
        else if (a == 1 && ch == 1)
        {
            printf("draw\n");
        }
        else if (a == 1 && ch == 2)
        {
            printf("you won\n");
            res++;
        }
        else if (a == 2 && ch == 0)
        {
            printf("you won\n");
            res++;
        }
        else if (a == 2 && ch == 1)
        {
            printf("you lost\n");
        }
        else
        {
            printf("draw\n");
        }
    }
}

printf("Your score is:%d\n", res);
system("pause");
new1->score = res;
    if (g3 == NULL)
    {
        g3 = new1;
    }
    else
    {
        new1->next = g3;
        g3 = new1;
    }
    sort(g3);
    display(g3);
}

int main()
{
    int ch;
    system("cls");
    while (ch != 5)
    {
        system("cls");
        system("color 03");
        printf("\n###############welcome to game dash board###############");
        printf("\nselect the games you want to play:");
        printf("\nenter\n<1> to play guessing number\n<2> to play cowsandbulls\n<3> to play rockpaperscissor");
        printf("\n<4> to exit the code");
        printf("\nenter your choice:");
        scanf("%d", &ch);

        switch (ch)
        {
        case 1:
            guess_number();
            break;
        case 2:
            cowsandbulls();
            break;
        case 3:
            rokpapciss();
            break;
        case 4:
            exit(0);
        default:
            printf("\nenter the proper input");
            exit(0);
        }
    }

    return 0;
}
