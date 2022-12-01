BEGIN{
count=0;
}
{
    if($1=="d")
        count++;
}
END{
    printf("The Total Number of Packets Dropped: %d\n\n", count);
}



