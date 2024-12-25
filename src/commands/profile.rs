use crate::{Context, Error};
use poise::serenity_prelude as serenity;

#[poise::command(slash_command)]
pub async fn profile(ctx: Context<'_>) -> Result<(), Error> {
    let user = ctx.author();

    let embed = serenity::CreateEmbed::new()
        .title(format!("{} profile", user.name))
        .field("Date of creation", format!("{}", user.created_at()), false);

    let response = poise::CreateReply::default().embed(embed);

    ctx.send(response).await?;
    Ok(())
}